//
//  UserDetailView.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 3.07.2025.
//

import SwiftUI

struct UserDetailView: View {
    @ObservedObject var viewModel: UserDetailViewModel
    @EnvironmentObject var router: RouterManager
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                BaseNavigationBar(
                    navigationTitle: viewModel.user.name ?? "Kullanıcı Detayları",
                    rightItemAction: {
                        viewModel.toggleFavorite()
                    }, 
                    rightItemIcon: viewModel.isFavorite ? "heart.fill" : "heart",
                    rightItemColor: viewModel.isFavorite ? Color.chiliRed : Color.cardShadow
                )
                profileSection

                contactInformationSection

                if let address = viewModel.user.address {
                    addressSection(address: address)
                }

                if let company = viewModel.user.company {
                    companySection(company: company)
                }
                
                Spacer(minLength: 50)
            }
            .padding()
        }
        .background(Color.background)
        .toast(ToastManager.shared)
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
    
    // MARK: - Profile Section
    private var profileSection: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color.accent.opacity(0.1))
                    .frame(width: 120, height: 120)
                
                Text(initials)
                    .font(.system(size: 36, weight: .medium))
                    .foregroundColor(Color.accent)
            }
            
            VStack(spacing: 4) {
                Text(viewModel.user.name ?? "Unknown User")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.textPrimary)
                
                Text("@\(viewModel.user.username ?? "")")
                    .font(.subheadline)
                    .foregroundColor(Color.textSecondary)
            }
        }
    }
    
    // MARK: - Contact Information Section
    private var contactInformationSection: some View {
        VStack(spacing: 16) {
            if let phone = viewModel.user.phone {
                contactRow(icon: "phone.fill",
                           title: UserDetailStrings.phoneTitle.value,
                           value: phone)
            }
            
            if let email = viewModel.user.email {
                contactRow(icon: "envelope.fill",
                           title: UserDetailStrings.emailTitle.value,
                           value: email)
            }
            
            if let website = viewModel.user.website {
                contactRow(icon: "globe",
                           title: UserDetailStrings.websiteTitle.value,
                           value: website)
            }
        }
    }
    
    // MARK: - Address Section
    private func addressSection(address: Address) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "location.fill")
                    .foregroundColor(Color.accent)
                    .frame(width: 20)
                
                Text(UserDetailStrings.addressTitle.value)
                    .font(.headline)
                    .foregroundColor(Color.textPrimary)
                
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                if let street = address.street, let suite = address.suite {
                    Text("\(street), \(suite)")
                        .foregroundColor(Color.textSecondary)
                }
                
                HStack {
                    if let city = address.city {
                        Text(city)
                            .foregroundColor(Color.textSecondary)
                    }
                    
                    if let zipcode = address.zipcode {
                        Text(zipcode)
                            .foregroundColor(Color.textSecondary)
                    }
                }
            }
            .padding(.leading, 28)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.background)
                .shadow(color: Color.cardShadow.opacity(0.1), radius: 8, x: 0, y: 2)
        )
    }
    
    // MARK: - Company Section
    private func companySection(company: Company) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "building.2.fill")
                    .foregroundColor(Color.accent)
                    .frame(width: 20)
                
                Text(UserDetailStrings.companyTitle.value)
                    .font(.headline)
                    .foregroundColor(Color.textPrimary)
                
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                if let name = company.name {
                    Text(name)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(Color.textPrimary)
                }
                
                if let catchPhrase = company.catchPhrase {
                    Text(catchPhrase)
                        .font(.caption)
                        .foregroundColor(Color.textSecondary)
                }
            }
            .padding(.leading, 28)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.background)
                .shadow(color: Color.cardShadow.opacity(0.1), radius: 8, x: 0, y: 2)
        )
    }
    
    // MARK: - Contact Row
    private func contactRow(icon: String, title: String, value: String) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(Color.accent)
                .frame(width: 20)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(Color.textSecondary)
                
                Text(value)
                    .font(.subheadline)
                    .foregroundColor(Color.textPrimary)
            }
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.background)
                .shadow(color: Color.cardShadow.opacity(0.1), radius: 8, x: 0, y: 2)
        )
    }
    
    // MARK: - Helper Properties
    private var initials: String {
        guard let name = viewModel.user.name else { return "?" }
        let components = name.components(separatedBy: " ")
        let initials = components.compactMap { $0.first }.prefix(2)
        return String(initials).uppercased()
    }
}
