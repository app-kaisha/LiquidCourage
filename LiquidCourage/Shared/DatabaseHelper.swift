//
//  DatabaseHelper.swift
//  SharedAssets
//
//  Created by app-kaihatsusha on 13/02/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import Foundation

struct DatabaseHelper {
    
    
    func getProducts() async throws -> [Product] {
        guard let url = URL(string: "https://dummyjson.com/products") else { throw URLError(.badURL)}
        let (data, _) = try await URLSession.shared.data(from: url)
        let product = try JSONDecoder().decode(ProductArray.self, from: data)
        return product.products
    }
    
    func getUsers() async throws -> [User] {
        guard let url = URL(string: "https://dummyjson.com/users") else { throw URLError(.badURL)}
        let (data, _) = try await URLSession.shared.data(from: url)
        let user = try JSONDecoder().decode(UserArray.self, from: data)
        return user.users
    }
}






