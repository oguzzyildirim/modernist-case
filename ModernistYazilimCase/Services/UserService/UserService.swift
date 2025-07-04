//
//  UserService.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 2.07.2025.
//

import Foundation
import Combine

protocol UserServiceProtocol: AnyObject {
    func getUsers() -> AnyPublisher<[User]?, Error>
}

final class UserService: UserServiceProtocol {
    
    private let httpClient: HTTPClient
    var subscriptions = Set<AnyCancellable>()
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    /// Fetches the list of users from the API
    /// - Returns: A publisher that emits an array of User objects or an error
    func getUsers() -> AnyPublisher<[User]?, Error> {
        return httpClient
            .publisher(UserProvider.users.makeRequest)
            .tryMap(UserMapper.map)
            .eraseToAnyPublisher()
    }
}
