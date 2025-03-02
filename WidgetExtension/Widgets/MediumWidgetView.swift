//
//  MediumWidgetView.swift
//  Git Stats
//
//  Created by Brian on 26/2/25.
//

import SwiftUI

struct MediumWidgetView: View {
    var entry: GitStatsUserEntry
    var colorScheme: ColorScheme
       
    
    init(entry: GitStatsUserEntry, colorScheme: ColorScheme) {
        self.entry = entry
        self.colorScheme = colorScheme
        
        // In giá trị entry để debug
//        print("🔍 entry.contributions: \(entry.contributions)")
    }

    var body: some View {
        
        let linkColor = colorScheme == .dark ? Color.white : Color.black
                
        Link(destination: URL(string: "githubstatswidget://user/\(entry.configuration.username ?? "bonnmh")")!) {
            HStack {
                VStack(alignment: .center, spacing: 10) {
                    UserInfoView(username: entry.configuration.username ?? "bonnmh", showUsername: entry.configuration.showUserName as? Bool ?? true, useProfilePicture: entry.configuration.useProfilePicture as? Bool ?? true, colorScheme: colorScheme, imageData: entry.avatarImageData, miniatureImage: true)
                    StatsInfoView(entry: entry, colorScheme: colorScheme)
                    if entry.configuration.showDate as? Bool ?? true {
                        DateInfoView()
                    }
                }
                .frame(maxWidth: .infinity)
                
                Divider()
                
                VStack (alignment: .trailing) {
                    ContributionsView(contributions: entry.contributions, numberOfDays: 51)
                }
                .frame(maxWidth: .infinity)
            }
        }.foregroundColor(linkColor)
    }
}
