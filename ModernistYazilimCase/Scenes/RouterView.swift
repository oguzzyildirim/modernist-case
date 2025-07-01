//
//  RouterView.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 30.06.2025.
//

import SwiftUI

struct RouterView: UIViewControllerRepresentable {
    
    let router = RouterManager.shared
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let navigationController = router.navigationController

        navigationController.navigationBar.isHidden = true
        navigationController.edgesForExtendedLayout = .all
        navigationController.extendedLayoutIncludesOpaqueBars = true
        
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) { }
}
