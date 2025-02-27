//
//  IconWithTextView.swift
//  Git Stats
//
//  Created by Brian on 26/2/25.
//


import SwiftUI
import WidgetKit

struct IconAndTextView: View {
    var type: String
    var currentCount: Int
    var previousCount: Int
    
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "\(type).fill")
                .scaledToFit()
                .frame(width: 16, height: 16)
            CountTextView(prefix: "", currentCount: currentCount, previousCount: previousCount)
        }
    }
}
