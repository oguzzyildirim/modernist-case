//
//  TabBarView.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 3.07.2025.
//

import SwiftUI

struct TabBarView: View {
    @AppStorage(StaticKeys.currentTab.key) private var currentTab: Int = TabBarItems.home.value
    @StateObject var homeViewModel: HomeViewModel
    @StateObject var favoritesViewModel: FavoritesViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                HomeView(viewModel: homeViewModel)
                    .tag(TabBarItems.home.value)
                
                FavoritesView(viewModel: favoritesViewModel)
                    .tag(TabBarItems.favorites.value)
            }
            .onAppear {
                UITabBar.appearance().isHidden = true
            }
            ModernistTabView()
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarHidden(true)
    }
}

