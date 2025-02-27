//
//  NotificationManager.swift
//  Git Stats
//
//  Created by Brian on 26/2/25.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let current = UNUserNotificationCenter.current()
    
    static func requestAuthorization() {
        current.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Authorization failed with error: \(error.localizedDescription)")
            }
        }
    }
    
    static func scheduleNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                print("Notification scheduled")
            }
        }
    }
}
