//
//  Settings.swift
//  Git Stats
//
//  Created by Brian on 26/2/25.
//


import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme
    
    let containerIconSize: CGFloat = 32
    let iconSize: CGFloat = 12
    let containerIconColorIndex: Int = 3

    @State var colorTheme: ColorTheme = ColorTheme.currentTheme
    @AppStorage("shouldRedirectToGitHub") private var shouldRedirectToGithub: Bool = false
    @AppStorage("notifyOnStatsChange") private var notifyOnStatsChange: Bool = false
    
    var body: some View {
        let linkColor = colorScheme == .dark ? Color.white : Color.black
        
        NavigationStack {
            List {
                Section(header: Text("")) {
                    NavigationLink {
                        ThemeSelectionView()
                    } label: {
                        Label {
                            Text("Theme")
                        } icon: {
                            Image(systemName: "paintpalette")
                                .font(.system(size: iconSize))
                                .foregroundColor(.white)
                                .background(
                                    Circle()
                                        .fill(colorTheme.colors[containerIconColorIndex]!)
                                        .frame(width: containerIconSize,height: containerIconSize)
                                )
                        }
                    }

                    
                    Toggle("Redirect to Github", isOn: $shouldRedirectToGithub)
                        .onChange(of: shouldRedirectToGithub) { oldValue, newValue in
                            UserDefaults.setShouldRedirectToGitHub(newValue)
                        }
                        .toggleStyle(SwitchToggleStyle(tint: colorTheme.colors[containerIconColorIndex]!))
                    
                    
                    Toggle("Notify on stats change", isOn: $notifyOnStatsChange)
                        .onChange(of: notifyOnStatsChange) { oldValue, newValue in
                            if newValue {
                                UNUserNotificationCenter.current()
                                    .requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                                        guard let error = error else { return }
                                        
                                        if granted {
                                            self.notifyOnStatsChange = true
                                            UserDefaults.setNotifyOnStatsChange(true)
                                        } else {
                                            self.notifyOnStatsChange = false
                                            UserDefaults.setNotifyOnStatsChange(false)
                                        }
                                    }
                            } else {
                                self.notifyOnStatsChange = false
                                UserDefaults.setNotifyOnStatsChange(false)
                            }
                        }
                        .toggleStyle(SwitchToggleStyle(tint: colorTheme.colors[containerIconColorIndex]!))

                    
                }
                
                Section(header: Text("About")) {
//                    Link(destination: URL(string: "https://apps.apple.com/vn/app/sudoku-sync/id6502610308")!) {
//                        Label {
//                            Text("Rate App")
//                                .foregroundColor(linkColor)
//                        } icon: {
//                            Image(systemName: "star")
//                                .font(.system(size: iconSize))
//                                .foregroundColor(.white)
//                                .background(
//                                    Circle()
//                                        .fill(colorTheme.colors[containerIconColorIndex]!)
//                                        .frame(width: containerIconSize,height: 30)
//                                )
//                        }
//                    }
                    
                    
                    let email = "blife.mobile@gmail.com"
                    let subject = "GitHub Stats Widget Feedback"
                    let encodedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                    
                    Link(destination: URL(string: "mailto:\(email)?subject=\(encodedSubject)")!) {
                        Label {
                            Text("Contact")
                                .foregroundColor(linkColor)
                        } icon: {
                            Image(systemName: "text.bubble")
                                .font(.system(size: iconSize))
                                .foregroundColor(.white)
                                .background(
                                    Circle()
                                        .fill(colorTheme.colors[containerIconColorIndex]!)
                                        .frame(width: containerIconSize,height: containerIconSize)
                                )
                        }
                    }
                    
                    Link(destination: URL(string: "https://github.com/bonnmh/Git-Stats")!) {
                        Label {
                            Text("Github Repo")
                                .foregroundColor(linkColor)
                        } icon: {
                            Image(systemName: "backpack")
                                .font(.system(size: iconSize))
                                .foregroundColor(.white)
                                .background(
                                    Circle()
                                        .fill(colorTheme.colors[containerIconColorIndex]!)
                                        .frame(width: containerIconSize,height: containerIconSize)
                                )
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
