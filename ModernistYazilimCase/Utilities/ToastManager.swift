//
//  ToastService.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 4.07.2025.
//

import Foundation

// MARK: - ToastManagerProtocol
protocol ToastManagerProtocol: ObservableObject {
    var toast: ToastMessage? { get }
    
    func showToast(_ toast: ToastMessage)
    func showSuccess(title: String, message: String)
    func showError(title: String, message: String)
    func showInfo(title: String, message: String)
}

// MARK: - ToastManager
final class ToastManager: ToastManagerProtocol {
    static let shared = ToastManager()
    @Published var toast: ToastMessage?
    
    func showToast(_ toast: ToastMessage) {
        self.toast = toast
        
        // Auto-dismiss after duration
        DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration) {
            self.toast = nil
        }
    }
    
    func showSuccess(title: String, message: String) {
        let toast = ToastMessage(type: .success, title: title, message: message)
        showToast(toast)
    }
    
    func showError(title: String, message: String) {
        let toast = ToastMessage(type: .error, title: title, message: message)
        showToast(toast)
    }
    
    func showInfo(title: String, message: String) {
        let toast = ToastMessage(type: .info, title: title, message: message)
        showToast(toast)
    }
} 
