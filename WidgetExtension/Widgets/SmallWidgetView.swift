//
//  SmallWidgetView.swift
//  Git Stats
//
//  Created by Brian on 26/2/25.
//

import SwiftUI

struct SmallWidgetView: View {
    var entry: GitStatsUserEntry
    var colorScheme: ColorScheme
    
    var body: some View {
        let linkColor = colorScheme == .dark ? Color.white : Color.black
        
        Link(destination: URL(string: "gitstatswidget://user/\(entry.configuration.username ?? "bonnmh")")!) {
            VStack(alignment: .center, spacing: 10) {
                UserInfoView(username: entry.configuration.username ?? "bonnmh", showUsername: entry.configuration.showUserName as? Bool ?? true, useProfilePicture: entry.configuration.useProfilePicture as? Bool ?? true, colorScheme: colorScheme, imageData: entry.avatarImageData, miniatureImage: true)
                StatsInfoView(entry: entry, colorScheme: colorScheme)
                if entry.configuration.showDate as? Bool ?? true {
                    DateInfoView()
                }
            }
        }.foregroundColor(linkColor)
    }
}
