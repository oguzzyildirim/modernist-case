//
//  HomeViewModel.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 2.07.2025.
//

import SwiftUI
import Combine

@MainActor
final class HomeViewModel: ObservableObject, HomeViewModelProtocol, ErrorHandling {
    let repo: HomeRepositoryProtocol
    @Published var searchText: String = ""
    @Published var users: [User] = []
    @Published var filteredUsers: [User] = []
    @Published var showAlert: Bool = false
    @Published var alertContent: CustomAlertView?
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init(repo: HomeRepositoryProtocol) {
        self.repo = repo
        self.addSubscribers()
    }
    
    /// Called when the view has loaded
    ///
    /// This method is empty but kept for protocol conformance and potential future initialization needs.
    func onAppear() {
        self.getUsers()
    }

    /// Fetches users from the repository
    ///
    /// This method:
    /// 1. Calls the repository to get user data
    /// 2. Handles success and error cases
    /// 3. Updates both the users and filteredUsers properties on success
    func getUsers() {
        isLoading = true
        
        repo.getUsers()
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    LogManager.shared.error("Failed to fetch users: \(error)")
                    self?.handleError(error,
                                      defaultMessage: DefaultErrorStrings.failedToLoadUsers.value)
                }
            }, receiveValue: { [weak self] users in
                guard let self = self, let users = users else { return }
                self.users = users
                self.filteredUsers = users
            })
            .store(in: &cancellables)
    }
    
    /// Filters the users based on a search query
    ///
    /// This method filters users by checking if the query string appears in the user's:
    /// - Name
    /// - Username
    /// - Email
    /// - City
    ///
    /// If the query is empty, all users are shown.
    ///
    /// - Parameter query: The search string used to filter users
    func filterUsers(with query: String) {
        if query.isEmpty {
            filteredUsers = users
            return
        }
        
        filteredUsers = users.filter { user in
            let nameMatch = user.name?.lowercased().contains(query.lowercased()) ?? false
            let usernameMatch = user.username?.lowercased().contains(query.lowercased()) ?? false
            let emailMatch = user.email?.lowercased().contains(query.lowercased()) ?? false
            let cityMatch = user.address?.city?.lowercased().contains(query.lowercased()) ?? false
            
            return nameMatch || usernameMatch || emailMatch || cityMatch
        }
    }
    
    /// Sets up reactive subscription for search text changes
    ///
    /// Automatically filters users when searchText changes with 300ms debounce
    /// to prevent excessive filtering during typing.
    func addSubscribers() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] searchText in
                self?.filterUsers(with: searchText)
            }
            .store(in: &cancellables)
    }
}
