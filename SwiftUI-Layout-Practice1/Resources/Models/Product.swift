//
//  Product.swift
//  SwiftUI-Layout-Practice1
//
//  Created by Jansen Ducusin on 7/16/25.
//

import Foundation

struct ProductResult: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

struct Product: Codable, Identifiable, Hashable {
    let id: Int
    let title, description: String
    let price, discountPercentage, rating: Double
    let stock: Int
    let brand: String?
    let category: String
    let images: [String]
    let thumbnail: String
    
    var firstImage: String {
        images.first ?? Constants.randomImage
    }
}

struct ProductRow: Identifiable {
    let id = UUID().uuidString
    let title: String
    let products: [Product]
}
