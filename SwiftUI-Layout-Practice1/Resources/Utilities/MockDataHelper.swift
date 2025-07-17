//
//  MockDataHelper.swift
//  SwiftUI-Layout-Practice1
//
//  Created by Jansen Ducusin on 7/16/25.
//

import Foundation

struct MockDataHelper {
    func getTracks() async throws -> [Track] {
        guard let url = URL(string: "https://jarvis-nodejs-7zr6.onrender.com/api/music/all")
        else { throw URLError(.badURL) }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode(TrackResult.self, from: data)
        
        return result.tracks
    }
    
    func getUsers() async throws -> [User] {
        guard let url = URL(string: "https://dummyjson.com/users")
        else { throw URLError(.badURL) }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode(UserResult.self, from: data)
        
        return result.users
    }
    
    func getRecentTracks() async throws -> [Track] {
        guard let url = URL(string: "https://jarvis-nodejs-7zr6.onrender.com/api/music/recents")
        else { throw URLError(.badURL) }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let result = try JSONDecoder().decode(TrackResult.self, from: data)
        
        return result.tracks
    }
}
