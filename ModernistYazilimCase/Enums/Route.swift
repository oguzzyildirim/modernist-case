//
//  Route.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 30.06.2025.
//

import SwiftUI

enum Route {
    case tabBar
    case splash
    case userDetail(User)
    
    var rotingType: RoutingType {
        switch self {
        case .tabBar, .splash, .userDetail:
            return .push
        }
    }
    
    @MainActor
    @ViewBuilder func view() -> some View {
        let httpClient = URLSession.shared
        let modelContext = RouterManager.shared.modelContext
        let favoriteManager = FavoriteManager(modelContext: modelContext)
        
        switch self {
        case .tabBar:
            // Dependency injection chain:
            let userService = UserService(httpClient: httpClient)
            let homeRepository = HomeRepository(userService: userService)
            let homeViewModel = HomeViewModel(repo: homeRepository)
            let favoritesViewModel = FavoritesViewModel(favoriteManager: favoriteManager)
            
            let view = TabBarView(homeViewModel: homeViewModel, favoritesViewModel: favoritesViewModel)
            view
        case .splash:
            let splashViewModel = SplashViewModel()
            let view = SplashView(viewModel: splashViewModel)
            view
        case .userDetail(let user):
            let userDetailViewModel = UserDetailViewModel(user: user, favoriteManager: favoriteManager)
            let view = UserDetailView(viewModel: userDetailViewModel)
            view
        }
    }
}
