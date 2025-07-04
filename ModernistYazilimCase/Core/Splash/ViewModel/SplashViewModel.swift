//
//  SplashViewModel.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 3.07.2025.
//

import SwiftUI

@MainActor
final class SplashViewModel: ObservableObject {
    @AppStorage(StaticKeys.currentTab.key) private var currentTab: Int = TabBarItems.home.value
    
    func onAppear() {
        showTabBarView()
    }
    
    func onDisappear() {
        LogManager.shared.info("SplashViewModel onDisappear")
    }
    
    func showTabBarView() {
        self.currentTab = TabBarItems.home.value
        RouterManager.shared.show(.tabBar, animated: false)
    }
}
