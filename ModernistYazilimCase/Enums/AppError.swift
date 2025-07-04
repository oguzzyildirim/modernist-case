//
//  AppError.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 4.07.2025.
//

import Foundation

// MARK: - AppError Protocol
protocol AppError: Error {
    var errorDescription: String? { get }
    var alertTitle: String { get }
}

// MARK: - Default Implementation
extension AppError {
    var alertTitle: String {
        return "Hata"
    }
} 