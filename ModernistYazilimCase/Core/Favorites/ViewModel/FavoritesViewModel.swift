//
//  FavoritesViewModel.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 4.07.2025.
//

import SwiftUI

@MainActor
final class FavoritesViewModel: ObservableObject, FavoritesViewModelProtocol, ErrorHandling {
    // MARK: - Published Properties
    @Published var favoriteUsers: [User] = []
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertContent: CustomAlertView?
    
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
            handleError(
                FavoriteError.invalidUserID,
                defaultMessage: DefaultErrorStrings.invalidCredentials.value
            )
            return
        }
        
        Task {
            do {
                try await favoriteManager.removeFavorite(userID: userID)
                await loadFavoriteUsers() // Refresh the list
                LogManager.shared.info("User \(userID) removed from favorites")
                
                // Show success toast
                ToastManager.shared.showInfo(
                    title: "Kaldırıldı",
                    message: "Kullanıcı favorilerden kaldırıldı"
                )
                
            } catch {
                handleError(error,
                            defaultMessage: DefaultErrorStrings.failedToRemoveFromFavorites.value)
            }
        }
    }
    
    // MARK: - Private Methods
    
    /// Loads favorite users from the database
    private func loadFavoriteUsers() async {
        isLoading = true
        
        do {
            let favorites = try await favoriteManager.getFavoriteUsers()
            favoriteUsers = favorites
            isLoading = false
            LogManager.shared.info("Loaded \(favorites.count) favorite users")
            
        } catch {
            isLoading = false
            handleError(error,
                        defaultMessage: DefaultErrorStrings.failedToLoadFavorites.value)
        }
    }
}
