//
//  FavoriteError.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 4.07.2025.
//

import Foundation

// MARK: - FavoriteError
enum FavoriteError: AppError {
    case invalidUserID
    case databaseError(Error)
    case userNotFound
    
    var errorDescription: String? {
        switch self {
        case .invalidUserID:
            return "Geçersiz kullanıcı kimliği"
        case .databaseError(let error):
            return "Veritabanı hatası: \(error.localizedDescription)"
        case .userNotFound:
            return "Kullanıcı bulunamadı"
        }
    }
    
    var alertTitle: String {
        return "Favori Hatası"
    }
}
