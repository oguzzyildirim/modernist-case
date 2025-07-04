//
//  ErrorHandling+Ext.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 4.07.2025.
//

import Foundation

@MainActor
protocol ErrorHandling: AnyObject {
    var showAlert: Bool { get set }
    var alertContent: CustomAlertView? { get set }
}

extension ErrorHandling {
    func handleError(_ error: Error, defaultMessage: String) {
        LogManager.shared.error("Error occurred: \(error)")
        
        let alert = if let appError = error as? AppError {
            CustomAlertView.error(appError) {
                [weak self] in
                    guard let self else { return }
                    self.showAlert = false
            }
        } else {
            CustomAlertView(title: "Hata", message: defaultMessage) { [weak self] in
                guard let self else { return }
                self.showAlert = false
            }
        }
        
        alertContent = alert
        showAlert = true
    }
}
