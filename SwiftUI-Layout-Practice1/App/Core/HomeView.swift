//
//  HomeView.swift
//  SwiftUI-Layout-Practice1
//
//  Created by Jansen Ducusin on 7/16/25.
//

import SwiftUI

struct HomeView: View {
    @State private var currentUser: User? = nil
    @State private var selectedCategory: Category? = nil
    @State private var products = [Product]()
    
    var body: some View {
        ZStack {
            Color.themeBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                LazyVStack(pinnedViews: [.sectionHeaders], content: {
                    Section {
                        VStack(spacing: 16) {
                            ProductGridSection(products: products)
                            
                            if let product = products.first {
                                newReleaseSection(product: product)
                            }
                        }
                        .padding(.horizontal, 16)
                        
                        ForEach(0..<20) { _ in
                            Rectangle()
                                .frame(width: 200, height: 200)
                        }
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
}

#Preview {
    HomeView()
}
