//
//  MainTab.swift
//  CustomTabView
//
//  Created by Itamar Gil on 3/30/24.
//

import SwiftUI

enum MainTab: String, Hashable, CaseIterable {
    case tab1 = "tab1"
    case tab2 = "tab2"
    case tab3 = "tab3"
    
    var index: Int {
        return MainTab.allCases.firstIndex(of: self) ?? 0
    }
    
    @ViewBuilder func view() -> some View {
        switch self {
        case .tab1:
            Text("tab1")
        case .tab2:
            Text("tab2")
        case .tab3:
            Text("tab3")
        }
    }
}
