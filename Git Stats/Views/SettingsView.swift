//
//  Settings.swift
//  Git Stats
//
//  Created by Brian on 26/2/25.
//


import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme
    let circleSize: CGFloat = 30
    let fontSize: CGFloat = 12
    let iconSize: CGFloat = 12
    let circleColorThemeIndex: Int = 3
    
    @State var colorTheme: ColorTheme = ColorTheme.currentTheme
    @AppStorage("shouldRedirectToGitHub") private var shouldRedirectToGitHub: Bool = false
    @AppStorage("notifyOnStatsChange") private var notifyOnStatsChange: Bool = false

    var body: some View {
        let linkColor = colorScheme == .dark ? Color.white : Color.black
                
        NavigationView {
            List {
                Section(header: Text("")) {
                    NavigationLink(destination: ThemeSelectionView()) {
                        Label {
                            Text(Localization.theme)
                        } icon: {
                            Image(systemName: "paintpalette")
                                .font(.system(size: iconSize))
                                .foregroundColor(.white)
                                .background(
                                    Circle().fill(colorTheme.colors[circleColorThemeIndex]!)
                                        .frame(width: circleSize, height: circleSize)
                                )
                        }
                    }
                    
                    Toggle(Localization.redirect_to_github, isOn: $shouldRedirectToGitHub)
                        .onChange(of: shouldRedirectToGitHub) { newValue in
                            UserDefaults.setShouldRedirectToGitHub(newValue)
                        }
                        .toggleStyle(SwitchToggleStyle(tint: colorTheme.colors[circleColorThemeIndex]!))
                    
                    Toggle(Localization.notify_on_stats_change, isOn: $notifyOnStatsChange)
                        .onChange(of: notifyOnStatsChange) { newValue in
                            if newValue {
                                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                                    DispatchQueue.main.async {
                                        guard error != nil else { return }
                                        
                                        if granted {
                                            self.notifyOnStatsChange = true
                                            UserDefaults.standard.set(true, forKey: "notifyOnStatsChange")
                                        } else {
                                            self.notifyOnStatsChange = false
                                            UserDefaults.standard.set(false, forKey: "notifyOnStatsChange")
                                        }
                                    }
                                }
                            } else {
                                self.notifyOnStatsChange = false

                                UserDefaults.standard.set(false, forKey: "notifyOnStatsChange")
                            }
                        }
                        .toggleStyle(SwitchToggleStyle(tint: colorTheme.colors[circleColorThemeIndex]!))
                    
                    
                }
                
                Section(header: Text("About")) {
                    
                    let email = "blife.mobile@gmail.com"
                    let subject = Localization.github_stats_widget_feedback
                    let encodedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                    
                    Link(destination: URL(string: "mailto:\(email)?subject=\(encodedSubject)")!) {
                        Label {
                            Text(Localization.contact).foregroundColor(linkColor)
                        } icon: {
                            Image(systemName: "envelope.fill")
                                .font(.system(size: iconSize))
                                .foregroundColor(.white)
                                .background(
                                    Circle().fill(colorTheme.colors[circleColorThemeIndex]!)
                                        .frame(width: circleSize, height: circleSize)
                                )
                        }
                    }
                    
                    Link(destination: URL(string: "https://github.com/bonnmh/Git-Stats")!) {
                        Label {
                            Text(Localization.github_repo).foregroundColor(linkColor)
                        } icon: {
                            Image(systemName: "backpack")
                                .font(.system(size: iconSize))
                                .foregroundColor(.white)
                                .background(
                                    Circle().fill(colorTheme.colors[circleColorThemeIndex]!)
                                        .frame(width: circleSize, height: circleSize)
                                )
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .onAppear {
                self.colorTheme = ColorTheme.currentTheme
                UNUserNotificationCenter.current().getNotificationSettings { settings in
                    DispatchQueue.main.async {
                        self.notifyOnStatsChange = settings.authorizationStatus == .authorized
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    SettingsView()
}
