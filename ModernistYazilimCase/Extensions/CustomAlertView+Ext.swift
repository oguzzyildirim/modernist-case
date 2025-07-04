//
//  CustomAlertView+Convenience.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 4.07.2025.
//

import SwiftUI

// MARK: - CustomAlertView Convenience Initializers
extension CustomAlertView {
    /// Creates an alert for any AppError
    static func error(_ error: AppError, onDismiss: @escaping () -> Void) -> CustomAlertView {
        return CustomAlertView(
            title: error.alertTitle,
            message: error.errorDescription ?? "Bilinmeyen bir hata oluştu",
            buttonTitle: "Tamam",
            buttonAction: onDismiss
        )
    }
}
