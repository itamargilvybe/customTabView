//
//  View+OffsetX.swift
//  CustomTabView
//
//  Created by Itamar Gil on 3/30/24.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder
    func offsetX(addObserver: Bool = false, completion: @escaping (CGFloat) -> ()) -> some View {
        self
            .overlay {
                if addObserver {
                    GeometryReader {
                        let rect = $0.frame(in: .global)
                        Color.clear
                            .preference(key: OffsetKey.self, value: rect)
                            .onPreferenceChange(OffsetKey.self) { value in
                                completion(value.minX)
                            }
                    }
                }
            }
    }
}

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
