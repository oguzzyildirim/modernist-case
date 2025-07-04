//
//  StaticKeys.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 2.07.2025.
//

import Foundation

enum StaticKeys {
    case currentTab
    
    var key: String {
        switch self {
            case .currentTab: return "currentTab"
        }
    }
}
