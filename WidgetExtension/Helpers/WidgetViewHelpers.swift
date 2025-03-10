//
//  WidgetViewHelpers.swift
//  Git Stats
//
//  Created by Brian on 26/2/25.
//

import SwiftUI
import WidgetKit

extension Int {
    func formatToK() -> String {
        if self >= 1_000_000 {
            let divided = Double(self) / 1_000_000.0
            return "\(Int(divided))M"
        } else if self >= 100_000 {
            let divided = Double(self) / 1_000.0
            return "\(Int(round(divided)))k"
        } else if self >= 1_000 {
            let divided = Double(self) / 1_000.0
            let formattedString = String(format: "%.1fk", divided)
            return formattedString.replacingOccurrences(of: ".0", with: "")
        } else {
            return "\(self)"
        }
    }
}

extension String {
    func slice(from: String, to: String) -> String? {
        (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}

extension UserDefaults {
    static var shared: UserDefaults? {
        return UserDefaults(suiteName: "group.blife.githubstatswidget")
    }

    static func setColorDict(_ value: [Int: Color], forKey key: String) {
        let hexColorDict = value.mapValues { $0.toHexString() }
        do {
            let encodedColors = try JSONEncoder().encode(hexColorDict)
            UserDefaults.shared?.set(encodedColors, forKey: key)
            WidgetCenter.shared.reloadAllTimelines()
        } catch {
            print("Failed to encode and save colors: \(error)")
        }
    }
    
    static func colorDict(forKey key: String) -> [Int: Color]? {
        guard let data = UserDefaults.shared?.data(forKey: key),
              let decodedHexColors = try? JSONDecoder().decode([Int: String].self, from: data) else {
            return nil
        }
        return decodedHexColors.mapValues { Color(hex: $0) }
    }
    
    static func setShouldRedirectToGitHub(_ value: Bool) {
        UserDefaults.shared?.set(value, forKey: "shouldRedirectToGitHub")
    }
    
    static func setNotifyOnStatsChange(_ value: Bool) {
        UserDefaults.shared?.set(value,forKey: "notifyOnStatsChange")
    }

    static func shouldRedirectToGitHub() -> Bool {
        return UserDefaults.shared?.bool(forKey: "shouldRedirectToGitHub") ?? false
    }
    
    static func setLockscreenWidgetUsername(lockscreenUsername: String) {
        UserDefaults.shared?.set(lockscreenUsername, forKey: "lockscreenWidgetUsername")
    }
    
    static func previousFollowersKey(forUsername username: String) -> String {
        "previousFollowers_\(username)"
    }

    static func previousStarsKey(forUsername username: String) -> String {
        "previousStars_\(username)"
    }

    static func updatePreviousValues(followers: Int, stars: Int, forUsername username: String) {
        UserDefaults.standard.set(followers, forKey: UserDefaults.previousFollowersKey(forUsername: username))
        UserDefaults.standard.set(stars, forKey: UserDefaults.previousStarsKey(forUsername: username))
    }

    static func getPreviousValues(forUsername username: String) -> (followers: Int, stars: Int) {
        (followers: UserDefaults.standard.integer(forKey: UserDefaults.previousFollowersKey(forUsername: username)),
         stars: UserDefaults.standard.integer(forKey: UserDefaults.previousStarsKey(forUsername: username)))
    }
    
    static func setFollowers(followers: [String], forUsername username: String) {
        let defaults = UserDefaults.standard
        defaults.set(followers, forKey: "followers_\(username)")
        WidgetCenter.shared.reloadAllTimelines()
    }

    static func getFollowers(forUsername username: String) -> [String] {
        let defaults = UserDefaults.standard
        return defaults.stringArray(forKey: "followers_\(username)") ?? []
    }
    
    static func setRepositoryStars(_ stars: [String: Int], forUsername username: String) {
        UserDefaults.standard.set(stars, forKey: "repoStars_\(username)")
    }

    static func getRepositoryStars(forUsername username: String) -> [String: Int] {
        UserDefaults.standard.object(forKey: "repoStars_\(username)") as? [String: Int] ?? [:]
    }
}

extension UIColor {
    var toHexString: String {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return String(format: "%02X%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255), Int(a * 255))
    }
    
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgba: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgba)
        
        let r = CGFloat((rgba & 0xFF000000) >> 24) / 255.0
        let g = CGFloat((rgba & 0x00FF0000) >> 16) / 255.0
        let b = CGFloat((rgba & 0x0000FF00) >> 8) / 255.0
        let a = CGFloat(rgba & 0x000000FF) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}

extension Color {
    func toHexString() -> String {
        return UIColor(self).toHexString
    }
    
    init(hex: String) {
        self = Color(UIColor(hex: hex) ?? .clear)
    }
}

extension Date {
    func isSameDay(as otherDate: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, inSameDayAs: otherDate)
    }
}

