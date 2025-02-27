//
//  GitStatsLockscreenView.swift
//  Git Stats
//
//  Created by Brian on 27/2/25.
//

import SwiftUI
import WidgetKit

struct GitStatsLockscreenView: View {
    
    let entry: GitStatsUserEntry
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        Group {
            switch widgetFamily {
            case .accessoryRectangular:
                RectangularWidgetView(entry: entry, colorScheme: colorScheme)
            default:
                Text("Unsupported widget family")
            }
        }
        .containerBackground(Color.white, for: .widget)
    }
}

struct GitStatsLockscreenView_Previews: PreviewProvider {
    static var previews: some View {
        GitStatsLockscreenView(entry: GitStatsUserEntry(
            date: Date(),
            username: "bonnmh",
            followers: 2,
            stars: 17,
            avatarImageData: nil,
            configuration: GitStatsUserConfigurationIntent(),
            previousFollowers: 0,
            previousStars: 0,
            contributions: sampleContributions
        ))
            .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
    }
}
