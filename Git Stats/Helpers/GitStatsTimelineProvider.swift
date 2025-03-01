//
//  GitStatsTimelineProvider.swift
//  Git Stats
//
//  Created by Brian on 26/2/25.
//

import WidgetKit
import SwiftUI
import UserNotifications

struct GitStatsTimelineProvider: IntentTimelineProvider {
    typealias Entry = GitStatsUserEntry
    typealias Intent = GitStatsUserConfigurationIntent
    
    func placeholder(in context: Context) -> GitStatsUserEntry {
        GitStatsUserEntry(date: Date(), username: "bonnmmh", followers: 100, stars: 200, avatarImageData: nil, configuration: GitStatsUserConfigurationIntent(), previousFollowers: 0, previousStars: 0, contributions: sampleContributions(days: 365))
    }
    
    func getSnapshot(for configuration: GitStatsUserConfigurationIntent, in context: Context, completion: @escaping (GitStatsUserEntry) -> Void) {
        completion(GitStatsUserEntry(date: Date(), username: "bonnmmh", followers: 3, stars: 20, avatarImageData: nil, configuration: configuration, previousFollowers: 0, previousStars: 0, contributions: sampleContributions(days: 365)))
    }

    func getTimeline(for configuration: GitStatsUserConfigurationIntent, in context: Context, completion: @escaping (Timeline<GitStatsUserEntry>) -> Void) {
        let username = configuration.username ?? "bonnmmh"
        fetchAndUpdateStats(username: username, configuration: configuration, completion: completion)
    }
    
    private func sampleContributions(days: Int) -> [Contribution] {
        (0..<days).map { day in
            Contribution(count: Int.random(in: 0...4), date: Calendar.current.date(byAdding: .day, value: -day, to: Date())!)
        }.reversed()
    }

    private func fetchAndUpdateStats(username: String, configuration: GitStatsUserConfigurationIntent, completion: @escaping (Timeline<GitStatsUserEntry>) -> Void) {
        // print("[DEBUG] start fetchAndUpdateStats")
        GithubAPIManager.shared.fetchGitHubUserStats(username: username) { statsResult in
            // print("[DEBUG] fetchAndUpdateStats statsResult: \(statsResult)")
            switch statsResult {
            case .success(let (user, repositories)):
                // fetch latest contributions
                ContributionFetcher().fetchContributions(username: username) { contributions in
                    URLSession.shared.dataTask(with: URL(string: user.avatar_url)!) { imageData, _, _ in
                        DispatchQueue.main.async {
                            // then, fetch and notify about changes in followers
                            GithubAPIManager.shared.fetchFollowers(username: username) { followersResult in
                                switch followersResult {
                                case .success(let currentFollowers):
                                    let previousFollowers = UserDefaults.getFollowers(forUsername: username)

                                    let newFollowers = currentFollowers.filter { !previousFollowers.contains($0) }
                                    let lostFollowers = previousFollowers.filter { !currentFollowers.contains($0) }

                                    newFollowers.forEach { follower in
                                        NotificationManager.scheduleNotification(
                                            title: "GitHub Stats - @\(username)",
                                            body: "\(follower) is now following \(username)"
                                        )
                                    }

                                    if !lostFollowers.isEmpty {
                                        NotificationManager.scheduleNotification(
                                            title: "GitHub Stats - @\(username)",
                                            body: "\(lostFollowers.count) followers unfollowed you"
                                        )
                                    }
                                    
                                    UserDefaults.setFollowers(followers: currentFollowers, forUsername: username)
                                case .failure(let error):
                                    print("Error fetching followers: \(error)")
                                }
                            }
                                
                            // finally, notify about changes in repo stars
                            let previousRepoStars = UserDefaults.getRepositoryStars(forUsername: username)
                            var currentRepoStars = [String: Int]()
                            let isFirstFetch = previousRepoStars.isEmpty

                            for repo in repositories {
                                let previousStars = previousRepoStars[repo.name] ?? 0
                                currentRepoStars[repo.name] = repo.stargazers_count

                                if repo.stargazers_count > previousStars && !isFirstFetch {
                                    let diff = repo.stargazers_count - previousStars
                                    NotificationManager.scheduleNotification(title: "GitHub Stats - @\(username)", body: "\(repo.name) gained \(diff) \(diff == 1 ? "star" : "stars")")
                                }
                            }

                            UserDefaults.setRepositoryStars(currentRepoStars, forUsername: username)

                            let currentDate = Date()
                            let refreshDate = Calendar.current.date(byAdding: .minute, value: 10, to: currentDate)!
                            let previousValues = UserDefaults.getPreviousValues(forUsername: username)
                            let totalStars = repositories.reduce(0) { $0 + $1.stargazers_count }

                            let entry = GitStatsUserEntry(
                                date: currentDate,
                                username: username,
                                followers: user.followers,
                                stars: totalStars,
                                avatarImageData: imageData,
                                configuration: configuration,
                                previousFollowers: previousValues.followers,
                                previousStars: previousValues.stars,
                                contributions: contributions
                            )
                            UserDefaults.updatePreviousValues(followers: user.followers, stars: totalStars, forUsername: username)
                            completion(Timeline(entries: [entry], policy: .after(refreshDate)))
                        }
                    }.resume()
                }
            case .failure(let error):
                print("Error fetching GitHub stats: \(error)")
                fallbackTimeline(username: username, configuration: configuration, completion: completion)
            }
        }
    }

    private func fallbackTimeline(username: String, configuration: GitStatsUserConfigurationIntent, completion: @escaping (Timeline<GitStatsUserEntry>) -> Void) {
        let previousValues = UserDefaults.getPreviousValues(forUsername: username)
        let fallbackEntry = GitStatsUserEntry(date: Date(), username: username, followers: previousValues.followers, stars: previousValues.stars, avatarImageData: nil, configuration: configuration, previousFollowers: previousValues.followers, previousStars: previousValues.stars, contributions: [])
        completion(Timeline(entries: [fallbackEntry], policy: .after(Date())))
    }}
