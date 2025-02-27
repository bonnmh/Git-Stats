//
//  GitStatsUserEntry.swift
//  Git Stats
//
//  Created by Brian on 26/2/25.
//


import WidgetKit

struct GitStatsUserEntry: TimelineEntry {
    let date: Date
    let username: String
    let followers: Int
    let stars: Int
    let avatarImageData: Data?
    let configuration: GitStatsUserConfigurationIntent
    let previousFollowers: Int
    let previousStars: Int
    let contributions: [Contribution]
}
