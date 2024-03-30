//
//  MainView.swift
//  CustomTabView
//
//  Created by Itamar Gil on 3/30/24.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var tabManager = MainTabsManager.shared
    
    var body: some View {
        GeometryReader {
            let safeArea = $0.safeAreaInsets
            let size = $0.size
            
            ZStack { // Toolbar indicator on top of views /IG
                
                // Holds main views, FullscreenCover, Sheet, and navigationDestinations /IG
                PagerTabView(selection: $tabManager.selectedTab, offset: $tabManager.tabOffset, screenWidth: size.width) {
                    ForEach(tabManager.allTabs, id: \.rawValue) { tab in
                        tab.view()
                            .frame(width: size.width) // for toolbar animation /IG
                            .offsetX(addObserver: tab == tabManager.selectedTab) { minX in // for toolbar animation /IG
                                // TODO something here causes first load not to open on .discover /IG
                                let offsetX = minX - (size.width * CGFloat(tab.index))
                                let maxOffset = CGFloat(MainTab.allCases.count - 1) * size.width
                                tabManager.chosenPage = max(min(offsetX, .zero), -maxOffset) / size.width
                            }
                            .ignoresSafeArea(.container, edges: .bottom)
                    }
                }
                
                // Interactive Toolbar /IG
                VStack {
                    HorizontalIndicatorView(safeArea: safeArea)
                    Spacer()
                }
            }
            .ignoresSafeArea()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct HorizontalIndicatorView: View {
    @ObservedObject var tabManager = MainTabsManager.shared
    let safeArea: EdgeInsets
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            let tabWidth = size.width / 3
            
            HStack(spacing: 0) {
                ForEach(tabManager.allTabs, id: \.rawValue) { tab in
                    Text(tab.rawValue)
                        .frame(width: tabWidth)
                        .onTapGesture {
                            tabManager.selectedTab = tab
                        }
                }
            }
            .frame(width: tabWidth * CGFloat(tabManager.allTabs.count), alignment: .leading)
            .padding(.leading, tabWidth)
            .offset(x: tabManager.chosenPage * tabWidth)
        }
        .frame(height: 45)
        .padding(.top, 15 + safeArea.top)
        .background {
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea()
        }
        .background(alignment: .bottom) {
            Divider()
        }
    }
}
