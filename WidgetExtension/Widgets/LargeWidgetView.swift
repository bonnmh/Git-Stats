//
//  LargeWidgetView.swift
//  Git Stats
//
//  Created by Brian on 27/2/25.
//

import SwiftUI

struct LargeWidgetView: View {
    var entry: GitStatsUserEntry
    var colorScheme: ColorScheme
    
    var body: some View {
        let linkColor = colorScheme == .dark ? Color.white : Color.black

        Link(destination: URL(string: "gitstatswidget://user/\(entry.configuration.username ?? "bonnmh")")!) {
            VStack(alignment: .center, spacing: 16) {
                UserInfoView(username: entry.configuration.username ?? "bonnmh", showUsername: entry.configuration.showUserName as? Bool ?? true, useProfilePicture: false, colorScheme: colorScheme, imageData: entry.avatarImageData)
                
                HStack {
                    StatsInfoView(entry: entry, colorScheme: colorScheme)
                        .frame(maxWidth: .infinity)
                    
                    Divider()
                    
                    UserAvatarView(imageData: entry.avatarImageData)
                        .frame(maxWidth: .infinity)
                }
                
                
                Divider()
                
                ContributionsView(contributions: entry.contributions, numberOfDays: (7*19) + 2)
                
                if entry.configuration.showDate as? Bool ?? true {
                    Divider()
                    
                    DateInfoView()
                }
            }
            .padding()
        }.foregroundColor(linkColor)
    }
}
