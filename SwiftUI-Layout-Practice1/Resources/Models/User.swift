//
//  User.swift
//  SwiftUI-Layout-Practice1
//
//  Created by Jansen Ducusin on 7/16/25.
//


import Foundation

struct UserResult: Codable {
    let users: [User]
    let total, skip, limit: Int
}

struct User: Codable, Identifiable {
    let id: Int
    let firstName, lastName: String
    let age: Int
    let email, phone, username, password: String
    let image: String
    let height, weight: Double
    
    static var mock: User {
        User(id: 02131993,
             firstName: "Sen",
             lastName: "Ducusin",
             age: 32,
             email: "senducusin@gmail.com",
             phone: "0919 008 1095",
             username: "Sen",
             password: "",
             image: Constants.randomImage,
             height: 5.5,
             weight: 66
        )
    }
}
