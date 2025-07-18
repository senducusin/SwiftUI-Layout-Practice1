//
//  Router.swift
//  SwiftUI-Layout-Practice1
//
//  Created by Jansen Ducusin on 7/18/25.
//

import Foundation
import SwiftUI
import Observation

struct RouteModel: Hashable {
    var user: User? = nil
    var track: Track? = nil
}

@Observable
class Router {
    var path = NavigationPath()
    
    func navigateToPlaylist(_ routeModel: RouteModel) {
        path.append(Route.playlist(model: routeModel))
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func dismissView() {
        path.removeLast()
    }
}

enum Route: Hashable {
    case playlist(model: RouteModel)
}
