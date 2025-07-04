//
//  UserProvider.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 2.07.2025.
//

import Foundation

enum UserProvider {
    case users
}

extension UserProvider: APIEndpoint {
    var baseURLString: String {
        return API.baseURL
    }
    
    var apiVersion: String? {
        return nil
    }
    
    var separatorPath: String? {
        return nil
    }
    
    var path: String {
        switch self {
        case .users:
            return "/users"
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .users:
            return ["Content-Type": "application/json"]
        default:
            return ["Content-Type": "application/json"]
        }
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    var params: [String: Any]? {
        return nil
    }
    
    var method: APIHTTPMethod {
        switch self {
        case .users:
            return .GET
        }
    }
    
    var customDataBody: Data? {
        return nil
    }
}
