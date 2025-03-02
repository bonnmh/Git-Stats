//
//  ThemeSelectionView.swift
//  Git Stats
//
//  Created by Brian on 26/2/25.
//

import SwiftUI

struct ThemeSelectionView: View {
    
    @State private var selectedColors: [Int: Color] = UserDefaults.colorDict(forKey: "widgetColors") ?? ColorTheme.defaults
    
    private func isSelectedTheme(_ theme: ColorTheme) -> Bool {
        return theme.colors == selectedColors
    }
    
    var body: some View {
        List {
            Section(Localization.color_theme) {
                ForEach(ColorTheme.themes, id: \.name) { theme in
                    HStack {
                        Text(theme.name)
                        Spacer()
                        ForEach(0..<5) { count in
                            Circle()
                                .fill(theme.colors[count, default: .gray.opacity(0.5)])
                                .frame(width: 13, height: 13)
                        }
                        
                        VStack {
                            if isSelectedTheme(theme) {
                                Image(systemName: "checkmark.circle")
                                    .padding(.leading, 12)
                                    .foregroundStyle(Color.green)
                            }
                        }
                        .frame(width: 24, alignment: .center)
                        
                    }
                    .onTapGesture {
                        selectedColors = theme.colors
                        UserDefaults.setColorDict(selectedColors, forKey: "widgetColors")
                    }
                }
            }
            
            Section(Localization.customize_colors) {
                ForEach(0..<5, id: \.self) { count in
                    HStack {
                        Text("\(contributionCountToString(count: count)) contributions")
                            .fixedSize(horizontal: true, vertical: false)
                        ColorPicker("", selection: binding(for: count))
                    }
                }
            }
        }
        .navigationTitle(Localization.theme_colors_selection)
    }
    
    private func contributionCountToString(count: Int) -> String {
        switch count {
            case 0: return "No"
            case 1: return "Low"
            case 2: return "Medium"
            case 3: return "Medium-High"
            case 4: return "High"
            default: return ""
        }
    }
    
    private func binding(for count: Int) -> Binding<Color> {
        Binding<Color>(
            get: {
                self.selectedColors[count, default: ColorTheme.defaults[count, default: .gray.opacity(0.5)]]
            },
            set: {
                self.selectedColors[count] = $0
                UserDefaults.setColorDict(self.selectedColors, forKey: "widgetColors")
            }
        )
    }
}

#Preview {
    ThemeSelectionView()
}
