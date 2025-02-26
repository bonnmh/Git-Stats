//
//  Settings.swift
//  Git Stats
//
//  Created by Brian on 26/2/25.
//


import SwiftUI

struct SettingsView: View {
    
    let containerIconSize: CGFloat = 32
    let iconSize: CGFloat = 12
    let containerIconColorIndex: Int = 3
    
    var body: some View {
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

                    
                    Toggle("Redirect to Github", isOn: .constant(true))
                        .toggleStyle(SwitchToggleStyle())
                    
                    
                    Toggle("Notify on stats change", isOn: .constant(true))
                        .toggleStyle(SwitchToggleStyle())
                    
                }
                
                Section(header: Text("About")) {
                    Link(destination: URL(string: "http://")!) {
                        Label {
                            Text("Rate App")
                                .foregroundColor(Color.red)
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
                                .foregroundColor(Color.red)
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
                                .foregroundColor(Color.red)
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
