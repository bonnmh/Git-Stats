//
//  GitStatsWidgetView.swift
//  Git Stats
//
//  Created by Brian on 26/2/25.
//

import SwiftUI
import WidgetKit

struct GitStatsWidgetView: View {
    let entry: GitStatsUserEntry
    @Environment(\.widgetFamily) var widgetFamily
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Group {
            if ( widgetFamily == .systemSmall) {
                SmallWidgetView(entry: entry, colorScheme: colorScheme)
            } else  if ( widgetFamily == .systemMedium) {
                MediumWidgetView(entry: entry, colorScheme: colorScheme)
            } else  if ( widgetFamily == .systemLarge) {
                LargeWidgetView(entry: entry, colorScheme: colorScheme)
            } else {
                SmallWidgetView(entry: entry, colorScheme: colorScheme)
            }
        }
        .containerBackground(
            Color("WidgetBackground").gradient,
            for: .widget
        )
    }
}

let sampleDays = 365
let sampleContributions: [Contribution] = (0..<sampleDays).map { day in
    let date = Calendar.current.date(byAdding: .day, value: -day, to: Date())!
    let count = Int.random(in: 0...4)
    return Contribution(count: count, date: date)
}.reversed()


struct GitHubStatsWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GitStatsWidgetView(
                entry: GitStatsUserEntry(
                    date: Date(),
                    username: "bonnmh",
                    followers: 2,
                    stars: 17,
                    avatarImageData: nil,
                    configuration: GitStatsUserConfigurationIntent(),
                    previousFollowers: 0,
                    previousStars: 0,
                    contributions: sampleContributions
                )
            )
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            .previewDisplayName("Small Widget")
             
            
//            GitStatsWidgetView(
//                entry: GitStatsUserEntry(
//                    date: Date(),
//                    username: "bonnmh",
//                    followers: 2,
//                    stars: 17,
//                    avatarImageData: nil,
//                    configuration: GitStatsUserConfigurationIntent(),
//                    previousFollowers: 0,
//                    previousStars: 0,
//                    contributions: sampleContributions
//                )
//            )
//            .previewContext(WidgetPreviewContext(family: .systemMedium))
//            .previewDisplayName("Medium Widget")
            
//            GitStatsWidgetView(
//                entry: GitStatsUserEntry(
//                    date: Date(),
//                    username: "bonnmh",
//                    followers: 2,
//                    stars: 17,
//                    avatarImageData: nil,
//                    configuration: GitStatsUserConfigurationIntent(),
//                    previousFollowers: 0,
//                    previousStars: 0,
//                    contributions: sampleContributions
//                )
//            )
//            .previewContext(WidgetPreviewContext(family: .systemLarge))
//            .previewDisplayName("Large Widget")
        }
    }
}

