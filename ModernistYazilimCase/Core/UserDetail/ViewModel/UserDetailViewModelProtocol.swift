//
//  UserDetailViewModelProtocol.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 3.07.2025.
//

import Foundation

protocol UserDetailViewModelProtocol: AnyObject {
    var user: User { get }
    var isFavorite: Bool { get }
    
    func toggleFavorite()
}
