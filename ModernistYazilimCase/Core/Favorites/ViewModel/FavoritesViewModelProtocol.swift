//
//  FavoritesViewModelProtocol.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 4.07.2025.
//

import Foundation

protocol FavoritesViewModelProtocol: AnyObject {
    var favoriteUsers: [User] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    
    func onAppear()
    func refreshFavorites()
    func removeFavorite(user: User)
}
