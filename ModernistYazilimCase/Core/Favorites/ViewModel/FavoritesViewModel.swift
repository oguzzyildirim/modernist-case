//
//  FavoritesViewModel.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 4.07.2025.
//

import SwiftUI

@MainActor
final class FavoritesViewModel: ObservableObject, FavoritesViewModelProtocol {
    
    // MARK: - Published Properties
    @Published var favoriteUsers: [User] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    // MARK: - Private Properties
    private let favoriteManager: FavoriteManagerProtocol
    
    // MARK: - Initialization
    init(favoriteManager: FavoriteManagerProtocol) {
        self.favoriteManager = favoriteManager
    }
    
    // MARK: - Public Methods
    
    /// Called when the view appears
    func onAppear() {
        refreshFavorites()
    }
    
    /// Refreshes the favorite users list
    func refreshFavorites() {
        Task {
            await loadFavoriteUsers()
        }
    }
    
    /// Removes a user from favorites
    /// - Parameter user: User to remove from favorites
    func removeFavorite(user: User) {
        guard let userID = user.id else {
            LogManager.shared.error("Invalid user ID for removal")
            return
        }
        
        Task {
            do {
                try await favoriteManager.removeFavorite(userID: userID)
                await loadFavoriteUsers() // Refresh the list
                LogManager.shared.info("User \(userID) removed from favorites")
            } catch {
                LogManager.shared.error("Failed to remove favorite: \(error)")
                await MainActor.run {
                    self.errorMessage = "Favoriden kaldırılamadı: \(error.localizedDescription)"
                }
            }
        }
    }
    
    // MARK: - Private Methods
    
    /// Loads favorite users from the database
    private func loadFavoriteUsers() async {
        await MainActor.run {
            self.isLoading = true
            self.errorMessage = nil
        }
        
        do {
            let favorites = try await favoriteManager.getFavoriteUsers()
            
            await MainActor.run {
                self.favoriteUsers = favorites
                self.isLoading = false
            }
            
            LogManager.shared.info("Loaded \(favorites.count) favorite users")
            
        } catch {
            LogManager.shared.error("Failed to load favorite users: \(error)")
            
            await MainActor.run {
                self.errorMessage = "Favoriler yüklenemedi: \(error.localizedDescription)"
                self.isLoading = false
            }
        }
    }
}
