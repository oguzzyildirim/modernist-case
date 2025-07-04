//
//  Strings.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 1.07.2025.
//


import Foundation

typealias HomeStrings = Strings.HomeStrings
typealias UserDetailStrings = Strings.UserDetailStrings
typealias DefaultErrorStrings = Strings.DefaultErrorStrings

enum Strings {
    enum HomeStrings {
        case headerTitle
        
        var value: String {
            switch self {
            case .headerTitle:
                return "Hoş geldiniz 👋🏻"
            }
        }
    }
    
    enum UserDetailStrings {
        case phoneTitle
        case emailTitle
        case websiteTitle
        case addressTitle
        case companyTitle
        
        var value: String {
            switch self {
            case .phoneTitle:
                return "Telefon"
            case .emailTitle:
                return "E-posta"
            case .websiteTitle:
                return "Website"
            case .addressTitle:
                return "Adres"
            case .companyTitle:
                return "Şirket"
            }
        }
    }
    
    enum DefaultErrorStrings {
        case invalidCredentials
        case failedToRemoveFromFavorites
        case failedToLoadFavorites
        case failedToLoadUsers
        case unexpectedFavoriteError
        
        var value: String {
            switch self {
            case .invalidCredentials:
                return "Geçersiz kullanıcı kimliği"
            case .failedToRemoveFromFavorites:
                return "Favoriden kaldırılamadı"
            case .failedToLoadFavorites:
                return "Favoriler yüklenemedi"
            case .failedToLoadUsers:
                return "Kullanıcılar yüklenirken bir hata oluştu. Lütfen tekrar deneyin."
            case .unexpectedFavoriteError:
                return "Favori işlemi sırasında beklenmedik bir hata oluştu"
            }
        }
    }
}
