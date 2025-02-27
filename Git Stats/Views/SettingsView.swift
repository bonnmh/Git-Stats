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
    
    @AppStorage("shouldRedirectToGithub") private var shouldRedirectToGithub: Bool = false
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
                                        .fill(Color.orange)
                                        .frame(width: containerIconSize,height: containerIconSize)
                                )
                        }
                    }

                    
                    Toggle("Redirect to Github", isOn: $shouldRedirectToGithub)
                        .toggleStyle(SwitchToggleStyle())
                        .onChange(of: shouldRedirectToGithub) { oldValue, newValue in
                            
                        }
                    
                    
                    Toggle("Notify on stats change", isOn: $notifyOnStatsChange)
                        .toggleStyle(SwitchToggleStyle())
                        .onChange(of: notifyOnStatsChange) { oldValue, newValue in
                            
                        }
                    
                }
                
                Section(header: Text("About")) {
                    Link(destination: URL(string: "http://")!) {
                        Label {
                            Text("Rate App")
                                .foregroundColor(linkColor)
                        } icon: {
                            Image(systemName: "star")
                                .font(.system(size: iconSize))
                                .foregroundColor(.white)
                                .background(
                                    Circle()
                                        .fill(Color.orange)
                                        .frame(width: containerIconSize,height: 30)
                                )
                        }
                    }
                    
                    Link(destination: URL(string: "http://")!) {
                        Label {
                            Text("Contact")
                                .foregroundColor(linkColor)
                        } icon: {
                            Image(systemName: "text.bubble")
                                .font(.system(size: iconSize))
                                .foregroundColor(.white)
                                .background(
                                    Circle()
                                        .fill(Color.orange)
                                        .frame(width: containerIconSize,height: containerIconSize)
                                )
                        }
                    }
                    
                    Link(destination: URL(string: "http://")!) {
                        Label {
                            Text("Github Repo")
                                .foregroundColor(linkColor)
                        } icon: {
                            Image(systemName: "backpack")
                                .font(.system(size: iconSize))
                                .foregroundColor(.white)
                                .background(
                                    Circle()
                                        .fill(Color.orange)
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
