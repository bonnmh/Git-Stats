//
//  WidgetExtensionBundle.swift
//  WidgetExtension
//
//  Created by Brian on 26/2/25.
//

import WidgetKit
import SwiftUI

@main
struct WidgetExtensionBundle: WidgetBundle {
    var body: some Widget {
        GitStatsWidget()
        GitStatsContributionWidget()
        if #available(iOS 16.1, *) {
            GitStatsLockscreenWidget()
        }
    }
}
