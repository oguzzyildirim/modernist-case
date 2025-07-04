//
//  UserData.swift
//  ModernistYazilimCase
//
//  Created by Oguz Yildirim on 3.07.2025.
//

import SwiftData
import Foundation

// MARK: - UserData
@Model
final class UserData {
    @Attribute(.unique) var id: Int
    var name: String?
    var username: String?
    var email: String?
    var address: AddressData?
    var phone: String?
    var website: String?
    var company: CompanyData?
    var isFavorite: Bool
    var dateAdded: Date
    
    init(from user: User, isFavorite: Bool = false) {
        self.id = user.id ?? 0
        self.name = user.name
        self.username = user.username
        self.email = user.email
        self.address = user.address != nil ? AddressData(from: user.address!) : nil
        self.phone = user.phone
        self.website = user.website
        self.company = user.company != nil ? CompanyData(from: user.company!) : nil
        self.isFavorite = isFavorite
        self.dateAdded = Date()
    }
    
    /// Converts UserData back to User struct for UI consumption
    func toUser() -> User {
        return User(
            id: self.id,
            name: self.name,
            username: self.username,
            email: self.email,
            address: self.address?.toAddress(),
            phone: self.phone,
            website: self.website,
            company: self.company?.toCompany()
        )
    }
}

// MARK: - AddressData
@Model
final class AddressData {
    var street: String?
    var suite: String?
    var city: String?
    var zipcode: String?
    var geo: GeoData?
    
    init(from address: Address) {
        self.street = address.street
        self.suite = address.suite
        self.city = address.city
        self.zipcode = address.zipcode
        self.geo = address.geo != nil ? GeoData(from: address.geo!) : nil
    }
    
    func toAddress() -> Address {
        return Address(
            street: self.street,
            suite: self.suite,
            city: self.city,
            zipcode: self.zipcode,
            geo: self.geo?.toGeo()
        )
    }
}

// MARK: - GeoData
@Model
final class GeoData {
    var lat: String?
    var lng: String?
    
    init(from geo: Geo) {
        self.lat = geo.lat
        self.lng = geo.lng
    }
    
    func toGeo() -> Geo {
        return Geo(lat: self.lat, lng: self.lng)
    }
}

// MARK: - CompanyData
@Model
final class CompanyData {
    var name: String?
    var catchPhrase: String?
    var bs: String?
    
    init(from company: Company) {
        self.name = company.name
        self.catchPhrase = company.catchPhrase
        self.bs = company.bs
    }
    
    func toCompany() -> Company {
        return Company(
            name: self.name,
            catchPhrase: self.catchPhrase,
            bs: self.bs
        )
    }
} 