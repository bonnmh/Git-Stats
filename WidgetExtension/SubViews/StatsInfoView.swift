//
//  StatsInfoView.swift
//  Git Stats
//
//  Created by Brian on 26/2/25.
//

import SwiftUI

struct StatsInfoView: View {
    var entry: GitStatsUserEntry
    var colorScheme: ColorScheme

    var body: some View {
        HStack {
            VStack {
                if entry.configuration.useIcons as? Bool ?? true {
                    Spacer()
                    IconAndTextView(type:entry.followers > 1 ? "person.2" : "person", currentCount: entry.followers, previousCount: entry.previousFollowers)
                        .foregroundColor(.primary)
                    Spacer()
                    Divider()
                    Spacer()
                    IconAndTextView(type: "star", currentCount: entry.stars, previousCount: entry.previousStars)
                        .foregroundColor(.primary)
                    Spacer()
                } else {
                    Spacer()
                    CountTextView(prefix: "Followers: ", currentCount: entry.followers, previousCount: entry.previousFollowers)
                    Spacer()
                    CountTextView(prefix: "Stars: ", currentCount: entry.stars, previousCount: entry.previousStars)
                    Spacer()
                }
            }
            .frame(maxWidth: entry.configuration.useIcons as? Bool ?? true ? 100 : .infinity)
        }
    }
}
