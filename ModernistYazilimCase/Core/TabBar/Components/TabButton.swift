//
//  TabButton.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 2.07.2025.
//

import SwiftUI

struct TabButton: View {
    let isFocused: Bool
    let focusedTabImage: ImageResource
    let unfocusedTabImage: ImageResource
    let title: String
    let tapAction: () -> Void
    
    var body: some View {
        Button(action: tapAction, label: {
            VStack(spacing: 0){
                Image(isFocused ? focusedTabImage : unfocusedTabImage)
                    .resizable()
                    .foregroundStyle(isFocused ? .cardShadow : .background)
                    .frame(width: 20, height: 20)
                
                Circle()
                    .fill(Color.accent)
                    .frame(width: 4, height: 4)
                    .opacity(isFocused ? 1 : 0)
                    .padding(.top, 4)
            }
            .frame(width: 36, height: 36)
            .background(
                Circle()
                    .fill(Color.background)
                    .opacity(isFocused ? 1 : 0)
            )
        })
    }
}
