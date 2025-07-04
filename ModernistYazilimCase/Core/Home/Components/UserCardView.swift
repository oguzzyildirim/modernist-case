//
//  UserCardView.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 1.07.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserCardView: View {
    let user: User
    let randomBackground = ColorManager.randomColors.randomElement() ?? Color.gray
    var width: CGFloat = 350
    var height: CGFloat = 200
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    WebImage(url: URL(string: "https://api.dicebear.com/9.x/avataaars/png?seed=12345")) { image in
                        image.resizable()
                            .frame(width: width * 0.2,
                                   height: width * 0.2,
                                   alignment: .leading)
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                    } placeholder: {
                        Rectangle()
                            .frame(width: width * 0.2,
                                   height: width * 0.2,
                                   alignment: .leading)
                            .foregroundColor(.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                    }
                    .onSuccess { image, data, cacheType in
                        // Success
                        // The image data must be saved as SwiftData
                    }
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .padding()
                    .background(
                        RadialGradient(
                            gradient: Gradient(colors: [
                                .white.opacity(0.7),
                                randomBackground.opacity(0.3)
                            ]),
                            center: .center,
                            startRadius: 5,
                            endRadius: 200
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                        .shadow(color: randomBackground, radius: 8, x: 0, y: 0)
                    )
                    
                    VStack(alignment: .leading){
                        
                        Text(user.name ?? "No Name")
                            .foregroundStyle(.white)
                            .font(.callout)
                        Text("@" + (user.username?.lowercased() ?? "unknown"))
                            .font(.caption)
                            .foregroundStyle(.white)
                        
                        VStack {
                            if let website = user.website {
                                Link(destination: URL(string: "https://" + website)!) {
                                    Text(website)
                                        .font(.caption)
                                        .underline()
                                        .foregroundStyle(.white)
                                }
                            } else {
                                Text("The website not found")
                                    .font(.caption)
                                    .foregroundStyle(.textSecondary)
                            }
                        }
                        .padding(.vertical, 6)
                    }
                    .padding(.horizontal, 6)
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            .frame(width: width, height: height)
            .background(
                RadialGradient(
                    gradient: Gradient(colors: [
                        randomBackground.opacity(0.8),
                        randomBackground.opacity(0.6)
                    ]),
                    center: .center,
                    startRadius: 5,
                    endRadius: 200
                )
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: randomBackground, radius: 8, x: 0, y: 0)
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: randomBackground, radius: 6, x: 0, y: 0)
        }
    }
}

#Preview {
    UserCardView(user: User(
        id: 1,
        name: "Leanne Graham",
        username: "Bret",
        email: "Sincere@april.biz",
        address: Address(
            street: "Kulas Light",
            suite: "Apt. 556",
            city: "Gwenborough",
            zipcode: "92998-3874",
            geo: Geo(lat: "-37.3159", lng: "81.1496")
        ),
        phone: "1-770-736-8031 x56442",
        website: "hildegard.org",
        company: Company(
            name: "Romaguera-Crona",
            catchPhrase: "Multi-layered client-server neural-net",
            bs: "harness real-time e-markets"
        )
    ))
}
