//
//  Route.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 30.06.2025.
//

import SwiftUI

enum Route {
    case contentView
    
    var rotingType: RoutingType {
        switch self {
        case .contentView:
            return .push
        }
    }
    
    @ViewBuilder func view() -> some View {
        switch self {
        case .contentView:
            let view = ContentView()
            view
        }
    }
}
