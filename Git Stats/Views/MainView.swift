//
//  MainView.swift
//  Git Stats
//
//  Created by Brian on 26/2/25.
//

import SwiftUI

struct Mainview: View {
    
    var body: some View {
        TabView {
            Tab("Received", systemImage: "book.pages.fill") {
                HomeView()
            }
            Tab("Sent", systemImage: "gear") {
                SettingsView()
            }
        }
    }
}

#Preview {
    Mainview()
}
