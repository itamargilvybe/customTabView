//
//  PagerTabView.swift
//  CustomTabView
//
//  Created by Itamar Gil on 3/30/24.
//

import Foundation
import SwiftUI

struct PagerTabView<Content: View>: View {
    var content: Content
    
    var screenWidth: CGFloat
    @Binding var offset: CGFloat
    @Binding var selection: MainTab
    
    init(selection: Binding<MainTab>, offset: Binding<CGFloat>, screenWidth: CGFloat, @ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        self._selection = selection
        self._offset = offset
        self.screenWidth = screenWidth
    }
    var body: some View {
        OffsetPageTabView(content: {
            HStack(spacing: 0) {
                content
            }
        }, offset: $offset, selection: $selection)
    }
}
