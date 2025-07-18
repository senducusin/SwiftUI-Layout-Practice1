//
//  RouterViewModifier.swift
//  SwiftUI-Layout-Practice1
//
//  Created by Jansen Ducusin on 7/18/25.
//

import Foundation
import SwiftUI

struct RouterViewModifier: ViewModifier {
    @State private var router = Router()
    
    private func routeView(for route: Route) -> some View {
        Group {
            switch route {
            case .playlist(let routeModel):
                if let track = routeModel.track,
                   let user = routeModel.user {
                    PlaylistView(track: track, user: user)
                } else {
                    PlaylistView()
                }
            }
        }
        .environment(router)
    }
    
    func body(content: Content) -> some View {
        NavigationStack(path: $router.path) {
            content
                .environment(router)
                .navigationDestination(for: Route.self) { route in
                    routeView(for: route)
                }
        }
    }
}

extension View {
    public func withRouter() -> some View {
        modifier(RouterViewModifier())
    }
}
