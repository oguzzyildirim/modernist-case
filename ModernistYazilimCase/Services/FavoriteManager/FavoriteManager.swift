//
//  FavoriteManager.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 3.07.2025.
//

import SwiftData
import Foundation
import Combine

// MARK: - FavoriteManagerProtocol
protocol FavoriteManagerProtocol {
    func toggleFavorite(for user: User) async throws
    func isFavorite(user: User) async -> Bool
    func getFavoriteUsers() async throws -> [User]
    func removeFavorite(userID: Int) async throws
}

// MARK: - FavoriteManager
@MainActor
final class FavoriteManager: FavoriteManagerProtocol {
    
    // MARK: - Properties
    private let modelContext: ModelContext
    
    // MARK: - Initialization
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    // MARK: - Public Methods
    
    /// Toggles favorite status for a user
    /// - Parameter user: User to toggle favorite status for
    func toggleFavorite(for user: User) async throws {
        guard let userID = user.id else {
            throw FavoriteError.invalidUserID
        }
        
        let fetchDescriptor = FetchDescriptor<UserData>(
            predicate: #Predicate { $0.id == userID }
        )
        
        do {
            let existingUsers = try modelContext.fetch(fetchDescriptor)
            
            if let existingUser = existingUsers.first {
                // User exists, toggle favorite status
                existingUser.isFavorite.toggle()
                LogManager.shared.info("Toggled favorite for user \(userID): \(existingUser.isFavorite)")
            } else {
                // User doesn't exist, create new with favorite = true
                let newUserData = UserData(from: user, isFavorite: true)
                modelContext.insert(newUserData)
                LogManager.shared.info("Added new favorite user: \(userID)")
            }
            
            try modelContext.save()
            
        } catch {
            LogManager.shared.error("Failed to toggle favorite: \(error)")
            throw FavoriteError.databaseError(error)
        }
    }
    
    /// Checks if a user is marked as favorite
    /// - Parameter user: User to check
    /// - Returns: Boolean indicating favorite status
    func isFavorite(user: User) async -> Bool {
        guard let userID = user.id else {
            return false
        }
        
        let fetchDescriptor = FetchDescriptor<UserData>(
            predicate: #Predicate { $0.id == userID && $0.isFavorite == true }
        )
        
        do {
            let favoriteUsers = try modelContext.fetch(fetchDescriptor)
            return !favoriteUsers.isEmpty
        } catch {
            LogManager.shared.error("Failed to check favorite status: \(error)")
            return false
        }
    }
    
    /// Gets all favorite users
    /// - Returns: Array of favorite users
    func getFavoriteUsers() async throws -> [User] {
        let fetchDescriptor = FetchDescriptor<UserData>(
            predicate: #Predicate { $0.isFavorite == true },
            sortBy: [SortDescriptor(\.dateAdded, order: .reverse)]
        )
        
        do {
            let favoriteUserData = try modelContext.fetch(fetchDescriptor)
            return favoriteUserData.map { $0.toUser() }
        } catch {
            LogManager.shared.error("Failed to fetch favorite users: \(error)")
            throw FavoriteError.databaseError(error)
        }
    }
    
    /// Removes a user from favorites
    /// - Parameter userID: ID of the user to remove from favorites
    func removeFavorite(userID: Int) async throws {
        let fetchDescriptor = FetchDescriptor<UserData>(
            predicate: #Predicate { $0.id == userID }
        )
        
        do {
            let users = try modelContext.fetch(fetchDescriptor)
            
            if let user = users.first {
                user.isFavorite = false
                try modelContext.save()
                LogManager.shared.info("Removed favorite for user: \(userID)")
            }
            
        } catch {
            LogManager.shared.error("Failed to remove favorite: \(error)")
            throw FavoriteError.databaseError(error)
        }
    }
}

// MARK: - FavoriteError
enum FavoriteError: LocalizedError {
    case invalidUserID
    case databaseError(Error)
    case userNotFound
    
    var errorDescription: String? {
        switch self {
        case .invalidUserID:
            return "Invalid user ID"
        case .databaseError(let error):
            return "Database error: \(error.localizedDescription)"
        case .userNotFound:
            return "User not found"
        }
    }
} 