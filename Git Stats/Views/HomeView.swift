//
//  HomeView.swift
//  Git Stats
//
//  Created by Brian on 26/2/25.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("")){
                    ForEach(HowToStep.allCases) { step in
                        HStack(alignment: .top){
                            Text("\(step.id + 1)")
                                .bold()
                            Text(step.description)
                                .padding(.leading, 2)
                        }
                    }
                }
            }
            .navigationTitle("How to work")
            .listStyle(InsetListStyle())
        }
    }
}

#Preview {
    HomeView()
}

enum HowToStep: Int, CaseIterable, Identifiable {
    case navigateHome
    case jiggleMode
    case addWidget
    case searchWidget
    case selectWidget
    case placeWidget
    case editWidget
    case editTheme
    
    var id: Int {
        return self.rawValue
    }
    
    var description: String {
        switch self {
        case .navigateHome:
            return "Navigate to your iPhone's home screen where you want to add the widget."
        case .jiggleMode:
            return "Long press on the background until the icons start jiggling."
        case .addWidget:
            return "Tap the '+' button in the upper-left corner of the screen."
        case .searchWidget:
            return "Search for 'GitHub Stats Widget' in the widget gallery."
        case .selectWidget:
            return "Tap 'Add Widget' after selecting the size you prefer."
        case .placeWidget:
            return "Position the widget on your home screen, then press 'Done' in the upper-right corner."
        case .editWidget:
            return "To adjust widget settings, enter ‘jiggle mode’, tap the widget, then select ‘Edit Widget’. Enter your username and change the settings to your liking."
        case .editTheme:
            return "To change the widget's color theme, navigate to Settings in this app and select your desired theme."
       }
    }
}
