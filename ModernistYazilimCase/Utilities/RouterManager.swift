//
//  RouterProtocol.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 30.06.2025.
//

import SwiftUI
import SwiftData

protocol RouterProtocol: ObservableObject {
    
    var navigationController: ModernistNavigationController { get }
    @MainActor var modelContext: ModelContext { get }
    
    func setModelContainer(_ container: ModelContainer)
    func start()
    func show(_ route: Route, animated: Bool)
    func showPopup(_ route: Route, transition: UIModalTransitionStyle, animated: Bool)
    func pop(animated: Bool)
    func popToRoot(animated: Bool)
    func popToFirstViewAfterRoot(animated: Bool)
    func dismiss(animated: Bool, completion: (() -> Void)?)
    func switchTab(index: Int)
    func removeInitialLoginView()
}

final class RouterManager: RouterProtocol {
    
    static let shared: any RouterProtocol = RouterManager()
    
    let navigationController: ModernistNavigationController = .init(nibName: nil, bundle: nil)
    
    private var modelContainer: ModelContainer?
    
    // MARK: - Public Properties
    @MainActor
    var modelContext: ModelContext {
        guard let container = modelContainer else {
            fatalError("Model container not set. Call setModelContainer() first.")
        }
        return container.mainContext
    }
    
    private init() {}
    
    func setModelContainer(_ container: ModelContainer) {
        self.modelContainer = container
    }
    
    func start() {
        show(.splash, animated: true)
    }
    
    func show(_ route: Route, animated: Bool) {
        DispatchQueue.main.async {
            let routeView = route.view()
            let viewWithRouter = routeView.environmentObject(self)
            let viewController = UIHostingController(rootView: viewWithRouter)
            
            viewController.navigationItem.hidesBackButton = true

            switch route.rotingType {
                
            case .push:
                LogManager.shared.info("Pushed: \(route)")
                self.navigationController.pushViewController(viewController, animated: animated)
                
            case .presentModally:
                LogManager.shared.info("Presented Modally: \(route)")
                viewController.modalPresentationStyle = .formSheet
                self.navigationController.present(viewController, animated: animated)
                
            case .presentFullScreen:
                LogManager.shared.info("Presented Full Screen: \(route)")
                viewController.modalPresentationStyle = .fullScreen
                self.navigationController.present(viewController, animated: animated)
            }
        }
    }
    
    func showPopup(_ route: Route, transition: UIModalTransitionStyle = .coverVertical, animated: Bool) {
        
        DispatchQueue.main.async {
            
            let routeView = route.view()
            let view = routeView.environmentObject(self)
            let viewController = UIHostingController(rootView: view)
            
            viewController.navigationItem.hidesBackButton = true
            
            switch route.rotingType {
                
            case .push, .presentModally:
                LogManager.shared.info("Presented Modally: \(route)")
                viewController.modalPresentationStyle = .formSheet
                viewController.modalTransitionStyle = transition
                self.navigationController.present(viewController, animated: animated)
                
            case .presentFullScreen:
                LogManager.shared.info("Presented Full Screen: \(route)")
                viewController.modalPresentationStyle = .overFullScreen
                viewController.modalTransitionStyle = transition
                self.navigationController.present(viewController, animated: animated)
            }
        }
    }
    
    func pop(animated: Bool) {
        
        DispatchQueue.main.async {
            self.navigationController.popViewController(animated: animated)
        }
    }
    
    func popToRoot(animated: Bool) {
        DispatchQueue.main.async {
            self.navigationController.popToRootViewController(animated: animated)
        }
    }
    
    func popToFirstViewAfterRoot(animated: Bool) {
        DispatchQueue.main.async {
            if self.navigationController.viewControllers.count > 1 {
                self.navigationController.popToViewController(self.navigationController.viewControllers[1], animated: animated)
            }
        }
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
        
        DispatchQueue.main.async {
            self.navigationController.presentedViewController?.dismiss(animated: animated, completion: completion)
        }
    }
    
    func switchTab(index: Int) {
        
        // Change tabbar selected index
    }
    
    func removeInitialLoginView() {
        DispatchQueue.main.async {
            if self.navigationController.viewControllers.count > 2 {
                self.navigationController.viewControllers.remove(at: 1)
            }
        }
    }
}
