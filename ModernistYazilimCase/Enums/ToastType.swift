//
//  ToastType.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 4.07.2025.
//

import SwiftUI

enum ToastType: Equatable {
    case success
    case error
    case info
    
    var backgroundColor: Color {
        switch self {
        case .success:
            return Color.delftBlue
        case .error:
            return Color.chiliRed
        case .info:
            return Color.mikadoYellow
        }
    }
    
    var iconName: String {
        switch self {
        case .success:
            return "checkmark.circle.fill"
        case .error:
            return "xmark.circle.fill"
        case .info:
            return "info.circle.fill"
        }
    }
} 