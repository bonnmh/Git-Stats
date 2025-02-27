//
//  DateInfoView.swift
//  Git Stats
//
//  Created by Brian on 26/2/25.
//

import SwiftUI
import WidgetKit

struct DateInfoView: View {
    var body: some View {
        Text(currentDateTimeString())
            .font(.system(size: 8, weight: .light))
            .lineLimit(1)
    }
    
    private func currentDateTimeString() -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale.current
        return formatter.string(from: now)
    }
}
