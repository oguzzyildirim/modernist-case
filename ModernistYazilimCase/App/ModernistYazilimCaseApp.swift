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
    
    // MARK: - SwiftData Container
    let container: ModelContainer = {
        let schema = Schema([
            UserData.self,
            AddressData.self,
            GeoData.self,
            CompanyData.self
        ])
        
        let configuration = ModelConfiguration(schema: schema)
        
        do {
            return try ModelContainer(for: schema, configurations: [configuration])
        } catch {
            fatalError("Failed to create SwiftData container: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            RouterView()
                .ignoresSafeArea(.all)
                .background(Color(UIColor.systemBackground))
                .modelContainer(container)
                .onAppear {
                    RouterManager.shared.setModelContainer(container)
                    RouterManager.shared.start()
                }
        }
    }
}
