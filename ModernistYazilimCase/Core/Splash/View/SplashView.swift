//
//  SplashView.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 3.07.2025.
//

import SwiftUI

struct SplashView: View {
    @StateObject var viewModel: SplashViewModel
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
                .onAppear(perform: viewModel.onAppear)
                .onDisappear(perform: viewModel.onDisappear)
            
            Image("SplashImage")
                .resizable()
                .frame(width: 144, height: 144)
        }
        .ignoresSafeArea()
        .toolbar(.hidden)
    }
}

#Preview {
    SplashView(viewModel: SplashViewModel())
}
