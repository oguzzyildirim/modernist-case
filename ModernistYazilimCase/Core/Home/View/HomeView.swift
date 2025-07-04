//
//  HomeView.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 1.07.2025.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    @EnvironmentObject var router: RouterManager
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            ZStack{
                VStack {
                    headerView
                        .background(Color.background)
                    SearchBarView(searchText: $viewModel.searchText)
                    
                    if viewModel.isLoading {
                        Spacer()
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.accent))
                        Spacer()
                    } else {
                        ScrollView{
                            LazyVGrid(columns: [GridItem(.flexible())], spacing: 12) {
                                ForEach(viewModel.filteredUsers, id: \.id) { user in
                                    UserCardView(user: user,
                                                 width: width * 0.85,
                                                 height: height * 0.25)
                                    .onTapGesture {
                                        router.show(.userDetail(user), animated: true)
                                    }
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                    }
                }
            }
            .onAppear {
                viewModel.onAppear()
            }
            .overlay(
                Group {
                    if viewModel.showAlert, let alertContent = viewModel.alertContent {
                        ZStack {
                            Color.black.opacity(0.3)
                                .ignoresSafeArea()
                                .onTapGesture {
                                    viewModel.showAlert = false
                                }
                            
                            alertContent
                        }
                        .animation(.easeInOut(duration: 0.3), value: viewModel.showAlert)
                    }
                }
            )
        }
    }
    
    private var headerView: some View {
        HStack {
            Text(HomeStrings.headerTitle.value)
                .font(.headline)
                .foregroundStyle(Color.accent)
                .padding()
            
            Spacer()
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(repo: HomeRepository(userService: UserService(httpClient: URLSession.shared))))
}
