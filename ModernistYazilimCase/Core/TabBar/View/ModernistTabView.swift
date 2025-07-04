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
    }
}

#Preview {
    ModernistTabView()
}
