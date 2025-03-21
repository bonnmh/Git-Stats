//
//  UserInfo.swift
//  Git Stats
//
//  Created by Brian on 26/2/25.
//

import SwiftUI

struct UserInfoView: View {
    var username: String
    var showUsername: Bool
    var useProfilePicture: Bool
    var colorScheme: ColorScheme
    var imageData: Data?
    var miniatureImage: Bool = false
    
    var body: some View {
        HStack {
            if (useProfilePicture) {
                UserAvatarView(imageData: imageData, miniatureImage: miniatureImage)
                    .scaledToFit()
                    .frame(width: 26, height: 26)
            } else {
                Image(colorScheme == .dark ? "github-light" : "github-dark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
            Text(showUsername ? username : "GitHub Stats")
                .font(.headline)
                .minimumScaleFactor(0.5)
                .lineLimit(4)
                .frame(height: 24, alignment: .center)
        }
    }
}

