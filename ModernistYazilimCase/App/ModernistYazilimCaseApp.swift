//
//  ModernistYazilimCaseApp.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 30.06.2025.
//

import SwiftUI
import SwiftData

@main
struct ModernistYazilimCaseApp: App {
    var body: some Scene {
        WindowGroup {
            RouterView()
                .ignoresSafeArea(.all)
                .background(Color(UIColor.systemBackground))
                .onAppear {
                    RouterManager.shared.start()
                }
        }
    }
}
