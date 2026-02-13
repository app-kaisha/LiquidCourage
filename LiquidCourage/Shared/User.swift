//
//  User.swift
//  SharedAssets
//
//  Created by app-kaihatsusha on 13/02/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//


struct UserArray: Codable {
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
}
