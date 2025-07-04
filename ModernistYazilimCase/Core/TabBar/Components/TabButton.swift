//
//  TabButton.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 2.07.2025.
//

//import SwiftUI
//
//struct TabButton: View {
//    
//    let isFocused: Bool
//    let tabImage: ImageResource
//    let title: String
//    let tapAction: () -> Void
//    
//    var body: some View {
//        Button(action: tapAction, label: {
//            VStack {
//                ZStack {
//                    Image(tabImage)
//                        .resizable()
//                        .foregroundStyle(isFocused ? .blue : .gray)
//                }
//                    .frame(width: 24, height: 24)
//                
//                Circle()
//                    .fill(Color.red)
//                    .frame(width: 6, height: 6)
//                    .opacity(isFocused ? 1 : 0)
//            }
//            .background(
//                RoundedRectangle(cornerRadius: 12)
//                    .foregroundStyle(Color.white)
//            )
//        })
//        .frame(maxWidth: .infinity)
//    }
//}
