//
//  CustomToastMessage.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 4.07.2025.
//

import SwiftUI

struct CustomToastMessage: View {
    let toast: ToastMessage
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: toast.type.iconName)
                .foregroundColor(.white)
                .font(.title2)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(toast.title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(toast.message)
                    .font(.body)
                    .foregroundColor(.white.opacity(0.9))
            }
            
            Spacer()
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(toast.type.backgroundColor)
                .shadow(color: Color.cardShadow.opacity(0.3), radius: 10, x: 0, y: 5)
        )
        .padding(.horizontal, 16)
    }
}
