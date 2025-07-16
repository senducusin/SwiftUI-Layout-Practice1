//
//  ProductGridSection.swift
//  SwiftUI-Layout-Practice1
//
//  Created by Jansen Ducusin on 7/16/25.
//

import SwiftUI

struct ProductGridSection: View {
    var products = [Product]()
    var numberOfColumns = 2
    
    var body: some View {
        let columns = Array(repeating: GridItem(.flexible()), count: numberOfColumns)
    
        return LazyVGrid(columns: columns) {
            ForEach(products, id: \.self) { product in
                RecentsCell(imageName: product.firstImage,
                            title: product.title)
            }
        }
    }
}
