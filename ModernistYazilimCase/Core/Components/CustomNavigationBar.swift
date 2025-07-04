//
//  CustomNavigationBar.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 3.07.2025.
//

import SwiftUI

struct BaseNavigationBar: View {
    @EnvironmentObject var router: RouterManager
    let navigationTitle: String
    let rightItemAction: (() -> Void)?
    let rightItemIcon: String?
    let rightItemColor: Color?
    
    init(navigationTitle: String,
         rightItemAction: (() -> Void)? = nil,
         rightItemIcon: String? = nil,
         rightItemColor: Color? = nil) {
        self.navigationTitle = navigationTitle
        self.rightItemAction = rightItemAction
        self.rightItemIcon = rightItemIcon
        self.rightItemColor = rightItemColor
    }
    
    var body: some View {
        VStack{
            ZStack {
                Color(.background)                
                HStack {
                    Button(action: {
                        router.pop(animated: true)
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.cardShadow)
                            .font(.system(size: 20))
                            .frame(width: 44, height: 44)
                    }
                    
                    Spacer()

                    Text(navigationTitle)
                        .font(.headline)
                        .foregroundColor(.cardShadow)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    if let rightItemIcon = rightItemIcon {
                        Button(action: {
                            rightItemAction?()
                        }) {
                            Image(systemName: rightItemIcon)
                                .foregroundColor(rightItemColor ?? .cardShadow)
                                .font(.system(size: 20))
                                .frame(width: 44, height: 44)
                        }
                    } else {
                        Spacer()
                            .frame(width: 44, height: 44)
                    }
                }
                .padding(.horizontal, 16)
            }
            .frame(height: 40)
            
            Spacer()
        }
    }
}
