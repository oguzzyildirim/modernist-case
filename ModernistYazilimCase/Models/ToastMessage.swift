//
//  ToastMessage.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 4.07.2025.
//

import Foundation

struct ToastMessage: Equatable {
    let type: ToastType
    let title: String
    let message: String
    let duration: Double
    
    init(type: ToastType, title: String, message: String, duration: Double = 3.0) {
        self.type = type
        self.title = title
        self.message = message
        self.duration = duration
    }
} 