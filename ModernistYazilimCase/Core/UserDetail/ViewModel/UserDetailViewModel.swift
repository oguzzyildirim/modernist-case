//
//  ViewModel.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 3.07.2025.
//

import SwiftUI
import SwiftData

@MainActor
final class UserDetailViewModel: ObservableObject, UserDetailViewModelProtocol, ErrorHandling {
    let user: User
    @Published var isFavorite: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertContent: CustomAlertView?
    
    
    private let favoriteManager: FavoriteManagerProtocol
    
    init(user: User, favoriteManager: FavoriteManagerProtocol) {
        self.user = user
        self.favoriteManager = favoriteManager
        
        Task {
            await loadFavoriteStatus()
        }
    }
    
    /// Toggles the favorite status of the user
    func toggleFavorite() {
        Task {
            do {
                let wasFavorite = isFavorite
                try await favoriteManager.toggleFavorite(for: user)
                await loadFavoriteStatus()
                
                // Show success message
                if wasFavorite {
                    ToastManager.shared.showInfo(
                        title: "Kaldırıldı",
                        message: "Kullanıcı favorilerden kaldırıldı"
                    )
                } else {
                    ToastManager.shared.showSuccess(
                        title: "Eklendi",
                        message: "Kullanıcı favorilere eklendi"
                    )
                }
                
            } catch {
                LogManager.shared.error("Failed to toggle favorite: \(error)")
                handleError(error,
                            defaultMessage: DefaultErrorStrings.unexpectedFavoriteError.value)
            }
        }
    }
    
    /// Loads the current favorite status from the database
    private func loadFavoriteStatus() async {
        let favoriteStatus = await favoriteManager.isFavorite(user: user)
        
        // Update UI on main thread
        await MainActor.run {
            self.isFavorite = favoriteStatus
        }
    }
}
