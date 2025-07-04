//
//  TabBarItems.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 2.07.2025.
//


import Foundation

enum TabBarItems {
    case home
    case favorites
    
    var value: Int {
        switch self {
        case .home:
            return 0
        case .favorites:
            return 1
        }
    }
    
    var label: String {
        switch self {
        case .home:
            return "Ana Sayfa"
        case .favorites:
            return "Favoriler"
        }
    }
}
