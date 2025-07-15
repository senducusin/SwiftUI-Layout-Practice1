//
//  ContentView.swift
//  SwiftUI-Layout-Practice1
//
//  Created by Jansen Ducusin on 7/16/25.
//

import SwiftUI

struct ContentView: View {
    @State private var users: [User] = []
    @State private var products: [Product] = []
    
    var body: some View {
        HomeView()
    }
    
    private func getData() async {
        do {
            users = try await MockDataHelper().getUsers()
            products = try await MockDataHelper().getProducts()
        } catch {
            
        }
    }
}

#Preview {
    ContentView()
}
