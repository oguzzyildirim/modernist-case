//
//  BlindIDCaseTabView.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 2.07.2025.
//

import SwiftUI

struct ModernistTabView: View {
    @AppStorage(StaticKeys.currentTab.key) private var currentTab: Int = TabBarItems.home.value
    
    var body: some View {
        HStack(alignment: .top) {
            TabButton(isFocused: currentTab == TabBarItems.home.value,
                      focusedTabImage: .homeFill,
                      unfocusedTabImage: .homeIcon,
                      title: TabBarItems.home.label) {
                currentTab = TabBarItems.home.value
            }
                      .padding(.horizontal)
            
            TabButton(isFocused: currentTab == TabBarItems.favorites.value,
                      focusedTabImage: .favoritesFill,
                      unfocusedTabImage: .favoritesIcon,
                      title: TabBarItems.favorites.label) {
                currentTab = TabBarItems.favorites.value
            }
                      .padding(.horizontal)
        }
        .padding(.all, 8)
        .background(
            RoundedRectangle(cornerRadius: 24)
        )
        .onChange(of: currentTab) { tab in
        }
    }
}

#Preview {
    ModernistTabView()
}

struct TabButton: View {
    let isFocused: Bool
    let focusedTabImage: ImageResource
    let unfocusedTabImage: ImageResource
    let title: String
    let tapAction: () -> Void
    
    var body: some View {
        Button(action: tapAction, label: {
            VStack(spacing: 0){
                Image(isFocused ? focusedTabImage : unfocusedTabImage)
                    .resizable()
                    .foregroundStyle(isFocused ? .cardShadow : .background)
                    .frame(width: 20, height: 20)
                
                Circle()
                    .fill(Color.accent)
                    .frame(width: 4, height: 4)
                    .opacity(isFocused ? 1 : 0)
                    .padding(.top, 4)
            }
            .frame(width: 36, height: 36)
            .background(
                Circle()
                    .fill(Color.background)
                    .opacity(isFocused ? 1 : 0)
            )
        })
    }
}
