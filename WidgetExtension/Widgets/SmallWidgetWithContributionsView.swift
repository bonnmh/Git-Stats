//
//  ContributionsWidgetView.swift
//  Git Stats
//
//  Created by Brian on 27/2/25.
//

import SwiftUI
import WidgetKit

struct SmallWidgetWithContributionsView: View {
    let entry: GitStatsUserEntry
    var colorScheme: ColorScheme
    
    var body: some View {
        let linkColor = colorScheme == .dark ? Color.white : Color.black

        Link(destination: URL(string: "gitstatswidget://user/\(entry.configuration.username ?? "bonnmh")")!) {
            VStack(alignment: .center, spacing: 0) {
                UserInfoView(username: entry.configuration.username ?? "bonnmh", showUsername: entry.configuration.showUserName as? Bool ?? true, useProfilePicture: entry.configuration.useProfilePicture as? Bool ?? true, colorScheme: colorScheme, imageData: entry.avatarImageData,  miniatureImage: true)
                Spacer()
                
                Divider()
                
                StatsInfoView(entry: entry, colorScheme: colorScheme)
                
                Divider()
                
                Spacer()
                
                ContributionsView(contributions: entry.contributions, numberOfDays: 7)
                
                Spacer()
                
                if entry.configuration.showDate as? Bool ?? true {
                    DateInfoView()
                }
            }
        }
    }
}
