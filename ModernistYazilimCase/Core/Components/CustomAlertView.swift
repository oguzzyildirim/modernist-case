//
//  CustomAlertView.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 4.07.2025.
//

import SwiftUI

struct CustomAlertView: View {
    let title: String
    let message: String
    let buttonTitle: String
    let buttonAction: () -> Void
    
    init(title: String, message: String, buttonTitle: String = "Tamam", buttonAction: @escaping () -> Void) {
        self.title = title
        self.message = message
        self.buttonTitle = buttonTitle
        self.buttonAction = buttonAction
    }
    
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 12) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color.textPrimary)
                    .multilineTextAlignment(.center)
                
                Text(message)
                    .font(.body)
                    .foregroundColor(Color.textSecondary)
                    .multilineTextAlignment(.center)
            }
            
            Button(action: buttonAction) {
                Text(buttonTitle)
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.chiliRed)
                    .cornerRadius(12)
            }
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.background)
                .shadow(color: Color.cardShadow.opacity(0.3), radius: 20, x: 0, y: 10)
        )
        .padding(.horizontal, 40)
    }
}
