//
//  HomeView.swift
//  SwiftUI-Layout-Practice1
//
//  Created by Jansen Ducusin on 7/16/25.
//

import SwiftUI
import SwiftfulUI

struct HomeView: View {
    @State private var currentUser: User? = nil
    @State private var selectedCategory: Category? = nil
    @State private var products = [Product]()
    @State private var productRows = [ProductRow]()
    
    var body: some View {
        ZStack {
            Color.themeBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                LazyVStack(pinnedViews: [.sectionHeaders], content: {
                    Section {
                        VStack(spacing: 16) {
                            recentsSection
                                .padding(.horizontal, 16)
                            
                            if let product = products.first {
                                newReleaseSection(product: product)
                                    .padding(.horizontal, 16)
                            }
                            
                            featuredSection
                        }
                        .padding(.horizontal, 16)
                        
                    } header: {
                        header
                    }
                })
                .padding(.top, 8)
            }
            .scrollIndicators(.hidden)
            .clipped()
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private func getData() async {
        do {
            currentUser = try await MockDataHelper().getUsers().last
            products = try await Array(MockDataHelper().getProducts().prefix(8))
            
            var rows = [ProductRow]()
            let allBrands: Set<String> = Set(products.compactMap { $0.brand })
            
            for brand in allBrands {
                /// add after finalizing the mock data
//                let products = products.filter { $0.brand == brand }
                rows.append(ProductRow(title: brand.capitalized,
                                       products: products))
            }
            
            productRows = rows
        } catch { }
    }
    
    private var header: some View {
        HStack(spacing: 0) {
            ZStack {
                if let currentUser {
                    ImageLoaderView(urlString: currentUser.image)
                        .background(.themeWhite)
                        .clipShape(Circle())
                        .onTapGesture {
                            
                        }
                }
            }
            .frame(width: 35, height: 35)
            
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(Category.allCases, id: \.self) { category in
                        CategoryCell(title: category.rawValue.capitalized,
                                     isSelected: selectedCategory == category)
                        .onTapGesture {
                            selectedCategory = category
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
        }
        .padding(.vertical, 24)
        .padding(.leading, 8)
        .background(Color.themeBlack)
    }
    
    private var recentsSection: some View {
        let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
        return LazyVGrid(columns: columns) {
            ForEach(products, id: \.self) { product in
                RecentsCell(imageName: product.firstImage,
                            title: product.title)
                .asButton(.press) {
                    
                }
            }
        }
    }
    
    private func newReleaseSection(product: Product) -> some View {
        NewReleaseCell(imageName: product.firstImage,
                       headline: product.brand,
                       subHeadline: product.category,
                       title: product.title,
                       subtitle: product.description,
                       onAddToPlaylistPressed: {
            dump("DEBUG: should add to playlist")
        }, onPlayPressed: {
            dump("DEBUG: should play media")
        })
    }
    
    private var featuredSection: some View {
        ForEach(productRows) { row in
            VStack(spacing: 8) {
                Text(row.title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.themeWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                
                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 16) {
                        ForEach(row.products) { product in
                            ImageTitleRowCell(imageSize: 120,
                                              imageName: product.firstImage,
                                              title: product.title)
                            .asButton(.press) {
                                
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    HomeView()
}
