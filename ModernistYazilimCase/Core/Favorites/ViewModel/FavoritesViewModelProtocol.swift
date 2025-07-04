//
//  FavoritesViewModelProtocol.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 4.07.2025.
//

import Foundation

@MainActor
protocol FavoritesViewModelProtocol: AnyObject, ErrorHandling {
    // MARK: - State
    var favoriteUsers: [User] { get }
    var isLoading: Bool { get }
    
    // MARK: - Actions
    func onAppear()
    func refreshFavorites()
    func removeFavorite(user: User)
}
