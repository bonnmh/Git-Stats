//
//  GitStatsContributionsView.swift
//  Git Stats
//
//  Created by Brian on 27/2/25.
//

import SwiftUI
import WidgetKit

struct GitStatsContributionsView: View {
    let entry: GitStatsUserEntry
    
    @Environment(\.widgetFamily) var widgetFamily
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Group {
            SmallWidgetWithContributionsView(entry: entry, colorScheme: colorScheme)
        }
        .containerBackground(Color.white, for: .widget)
    }
}
 
struct GitStatsContributionsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GitStatsContributionsView(
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
        }
    }
}
