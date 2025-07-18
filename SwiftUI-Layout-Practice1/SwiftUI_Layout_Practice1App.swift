//
//  SwiftUI_Layout_Practice1App.swift
//  SwiftUI-Layout-Practice1
//
//  Created by Jansen Ducusin on 7/16/25.
//

import SwiftUI
import SwiftfulRouting

@main
struct SwiftUI_Layout_Practice1App: App {
    var body: some Scene {
        WindowGroup {
            RouterView { _ in
                ContentView()
            }
        }
    }
}

extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
