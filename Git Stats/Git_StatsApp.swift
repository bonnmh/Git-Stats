//
//  Git_StatsApp.swift
//  Git Stats
//
//  Created by Brian on 26/2/25.
//

import SwiftUI
import WidgetKit

@main
struct Git_StatsApp: App {
//    @Environment(\.scenePhase) private var scenePhase
    var body: some Scene {
        WindowGroup {
            Mainview()
//                .onChange(of: scenePhase) { oldValue, newValue in
//                    if newValue == .background {
//                        print("reloadAllTimelines")
//                        WidgetCenter.shared.reloadAllTimelines()
//                    }
//                }
        }
    }
}
