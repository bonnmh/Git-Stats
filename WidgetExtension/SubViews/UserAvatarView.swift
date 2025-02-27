//
//  UserAvatarView.swift
//  Git Stats
//
//  Created by Brian on 26/2/25.
//

import SwiftUI

struct UserAvatarView: View {
    var imageData: Data?
    var miniatureImage: Bool = false

    var body: some View {
        Group {
            if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Image("placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(.gray)
            }
        }
        .clipShape(Circle())
        .shadow(radius: miniatureImage ? 1 : 5)
        .frame(width: miniatureImage ? nil : 100, height: miniatureImage ? nil : 100)
    }
}
