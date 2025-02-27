//
//  WidgetExtension.swift
//  WidgetExtension
//
//  Created by Brian on 26/2/25.
//

import WidgetKit
import SwiftUI

struct GitStatsWidget: Widget {
    let kind: String = "GitStatsWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: GitStatsUserConfigurationIntent.self, provider: GitStatsTimelineProvider()) { entry in
            GitStatsWidgetView(entry: entry)
        }
        .configurationDisplayName("GitHub Stats")
        .description("Displays GitHub followers and stars.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}
 
struct GitStatsContributionWidget: Widget {
    let kind: String = "GitStatsContributionWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: GitStatsUserConfigurationIntent.self, provider: GitStatsTimelineProvider()) { entry in
            GitStatsContributionsView(entry: entry)
        }
        .configurationDisplayName("GitHub Stats")
        .description("Displays GitHub followers and stars with this weeks contributions")
        .supportedFamilies([.systemSmall])
    }
}

@available(iOSApplicationExtension 16.1, *)
struct GitStatsLockscreenWidget: Widget {
    let kind: String = "GitStatsLockscreenWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: GitStatsUserConfigurationIntent.self, provider: GitStatsTimelineProvider()) { entry in
            GitStatsLockscreenView(entry: entry)
        }
        .configurationDisplayName("GitHub Stats")
        .description("Displays GitHub followers and stars.")
        .supportedFamilies([.accessoryRectangular])
    }
}

