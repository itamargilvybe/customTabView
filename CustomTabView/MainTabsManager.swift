//
//  MainTabsManager.swift
//  CustomTabView
//
//  Created by Itamar Gil on 3/30/24.
//

import SwiftUI

class MainTabsManager: ObservableObject {
    private init(){}
    
    static let shared = MainTabsManager()
    
    let allTabs: [MainTab] = MainTab.allCases
    
    @Published var selectedTab: MainTab = .tab1
    @Published var tabOffset: CGFloat = .zero
    @Published var chosenPage: CGFloat = .zero // Dictates which page we're on /IG
}
