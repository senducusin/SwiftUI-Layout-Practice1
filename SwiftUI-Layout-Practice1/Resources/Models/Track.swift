//
//  Track.swift
//  SwiftUI-Layout-Practice1
//
//  Created by Jansen Ducusin on 7/17/25.
//
import Foundation

struct TrackResult: Codable {
    let tracks: [Track]
}

// MARK: - Track
struct Track: Codable, Identifiable, Hashable {
    let id, artist, trackName, album: String
    let albumCover: String
    let genre: Genre
}

enum Genre: String, Codable {
    case acoustic = "acoustic"
    case hipHop = "hip-hop"
    case jazz = "jazz"
    case pop = "pop"
    case rock = "rock"
    case romance = "romance"
}

struct TrackRow: Identifiable {
    let id = UUID().uuidString
    let title: String
    let tracks: [Track]
}
