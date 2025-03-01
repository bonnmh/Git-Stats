//
//  MainView.swift
//  Git Stats
//
//  Created by Brian on 26/2/25.
//

import SwiftUI

struct Mainview: View {
    @AppStorage("shouldRedirectToGitHub") var shouldRedirectToGitHub: Bool = false
    
    var body: some View {
        TabView {
            Tab("Received", systemImage: "book.pages.fill") {
                HomeView()
            }
            Tab("Sent", systemImage: "gear") {
                SettingsView()
            }
        }
        .onOpenURL { url in
            if shouldRedirectToGitHub,
               url.scheme == "gitstatswidget",
               let username = url.pathComponents.last {
                let userURL = URL(string: "https://github.com/\(username)")!
                UIApplication.shared.open(userURL)
            }
        }
    }
}

#Preview {
    Mainview()
}
