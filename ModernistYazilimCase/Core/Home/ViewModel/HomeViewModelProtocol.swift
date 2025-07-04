//
//  HomeViewModelProtocol.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 3.07.2025.
//

import Foundation

@MainActor
protocol HomeViewModelProtocol: AnyObject {
    // Properties
    var users: [User] { get }
    
    // Lifecycle methods
    func onAppear()
    
    // Data methods
    func getUsers()
}
