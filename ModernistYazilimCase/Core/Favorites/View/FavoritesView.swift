//
//  FavoritesView.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 30.06.2025.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: FavoritesViewModel
    @EnvironmentObject var router: RouterManager
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            
            VStack(spacing: 0) {
                // Header
                headerView
                    .background(Color.background)
                
                // Content
                if viewModel.isLoading {
                    loadingView
                } else if viewModel.favoriteUsers.isEmpty {
                    emptyStateView
                } else {
                    favoritesList(width: width, height: height)
                }
            }
            .background(Color.background)
            .onAppear {
                viewModel.onAppear()
            }
            .refreshable {
                viewModel.refreshFavorites()
            }
        }
    }
    
    // MARK: - Header View
    private var headerView: some View {
        HStack {
            Text("Favorilerim ❤️")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color.accent)
                .padding()
            
            Spacer()
            
            Button(action: {
                viewModel.refreshFavorites()
            }) {
                Image(systemName: "arrow.clockwise")
                    .foregroundColor(Color.accent)
                    .font(.title2)
            }
            .padding(.trailing)
        }
    }
    
    // MARK: - Loading View
    private var loadingView: some View {
        VStack {
            Spacer()
            ProgressView("Favoriler yükleniyor...")
                .foregroundColor(Color.accent)
            Spacer()
        }
    }
    
    // MARK: - Empty State View
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Image(systemName: "heart.slash")
                .font(.system(size: 60))
                .foregroundColor(Color.textSecondary)
            
            Text("Henüz favori kullanıcın yok")
                .font(.title2)
                .foregroundColor(Color.textPrimary)
            
            Text("Kullanıcı detaylarından kalp simgesine tıklayarak favori ekleyebilirsin")
                .font(.subheadline)
                .foregroundColor(Color.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
        }
    }
    
    // MARK: - Favorites List
    private func favoritesList(width: CGFloat, height: CGFloat) -> some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible())], spacing: 12) {
                ForEach(viewModel.favoriteUsers, id: \.id) { user in
                    UserCardView(user: user,
                                 width: width * 0.85,
                                 height: height * 0.25)
                    .onTapGesture {
                        router.show(.userDetail(user), animated: true)
                    }
                    .contextMenu {
                        Button(role: .destructive) {
                            viewModel.removeFavorite(user: user)
                        } label: {
                            Label("Favorilerden Kaldır", systemImage: "heart.slash")
                        }
                    }
                }
            }
            .padding()
        }
        .scrollIndicators(.hidden)
    }
}
