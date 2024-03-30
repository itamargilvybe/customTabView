//
//  OffsetPageTabView.swift
//  CustomTabView
//
//  Created by Itamar Gil on 3/30/24.
//

import SwiftUI

struct OffsetPageTabView<Content: View>: UIViewRepresentable {
    var content: Content
    @Binding var offset: CGFloat
    @Binding var selection: MainTab
    
    init(@ViewBuilder content: @escaping () -> Content , offset: Binding<CGFloat>, selection: Binding<MainTab>) {
        self.content = content()
        self._offset = offset
        self._selection = selection
    }
    
    func makeCoordinator() -> Coordinator {
        return OffsetPageTabView.Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> some UIScrollView {
        
        // Extracting swiftui view and enbedding into uikit scrollview
        let scrollview = UIScrollView()
        let hostview = UIHostingController(rootView: content)
        hostview.view.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            hostview.view.topAnchor.constraint(equalTo: scrollview.topAnchor),
            hostview.view.leadingAnchor.constraint(equalTo: scrollview.leadingAnchor),
            hostview.view.trailingAnchor.constraint(equalTo: scrollview.trailingAnchor),
            hostview.view.bottomAnchor.constraint(equalTo: scrollview.bottomAnchor),
            hostview.view.heightAnchor.constraint(equalTo: scrollview.heightAnchor)
        ]
        
        scrollview.addSubview(hostview.view)
        scrollview.addConstraints(constraints)
        
        // Enabling paging
        scrollview.isPagingEnabled = true
        scrollview.showsVerticalScrollIndicator = false
        scrollview.showsHorizontalScrollIndicator = false
        
        // Setting delegate
        scrollview.delegate = context.coordinator
        scrollview.keyboardDismissMode = .onDrag // Makes sure any open keyboard will be dismissed if a tab is being swiped on /IG
        
        return scrollview
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard uiView.bounds.width > 0 else { return }
        let page = Int(uiView.contentOffset.x / uiView.bounds.width)
        if selection.index != page {
            uiView.setContentOffset(.init(x: CGFloat(selection.index) * uiView.bounds.width, y: 0), animated: true)
        }
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: OffsetPageTabView
        
        init(parent: OffsetPageTabView) {
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            parent.offset = scrollView.contentOffset.x
            let page = Int(scrollView.contentOffset.x.rounded()) / Int(scrollView.bounds.width)
            parent.selection = MainTab.allCases[page]
        }
    }
}
