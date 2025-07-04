//
//  View+Toast.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 4.07.2025.
//

import SwiftUI

// MARK: - Toast View Modifier
struct ToastModifier: ViewModifier {
    @ObservedObject var toastService: ToastManager
    
    func body(content: Content) -> some View {
        content
            .overlay(
                VStack {
                    if let toast = toastService.toast {
                        CustomToastMessage(toast: toast)
                            .transition(.move(edge: .top).combined(with: .opacity))
                            .animation(.easeInOut(duration: 0.3), value: toastService.toast)
                    }
                    
                    Spacer()
                }
                .padding(.top, 50)
            )
    }
}

// MARK: - View Extension
extension View {
    func toast(_ toastService: ToastManager) -> some View {
        self.modifier(ToastModifier(toastService: toastService))
    }
}
