//
//  HomeView.swift
//  Git Stats
//
//  Created by Brian on 26/2/25.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        if #available(iOS 16.0, *) {
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
                .navigationTitle(Localization.how_to_work)
                .listStyle(InsetListStyle())
            }
        } else {
            // Fallback on earlier versions
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
            return Localization.navigate_home
        case .jiggleMode:
            return Localization.jiggle_mode
        case .addWidget:
            return Localization.add_widget
        case .searchWidget:
            return Localization.search_widget
        case .selectWidget:
            return Localization.select_widget
        case .placeWidget:
            return Localization.place_widget
        case .editWidget:
            return Localization.edit_widget
        case .editTheme:
            return Localization.edit_theme
       }
    }
}
