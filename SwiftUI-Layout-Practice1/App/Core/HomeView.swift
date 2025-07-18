//
//  HomeView.swift
//  SwiftUI-Layout-Practice1
//
//  Created by Jansen Ducusin on 7/16/25.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct HomeView: View {
    @Environment(\.router) var router
    
    @State private var currentUser: User? = .mock
    @State private var selectedCategory: Category? = nil
    @State private var tracks = [Track]()
    @State private var recentTracks = [Track]()
    @State private var trackRows: [TrackRow] = []
    
    var body: some View {
        ZStack {
            Color.themeBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                LazyVStack(pinnedViews: [.sectionHeaders], content: {
                    Section {
                        VStack(spacing: 16) {
                            recentsSection
                                .padding(.horizontal, 16)
                            
                            if let track = tracks.first {
                                newReleaseSection(track: track)
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
            tracks = try await MockDataHelper().getTracks()
            recentTracks = try await MockDataHelper().getRecentTracks()
            
            var rows = [TrackRow]()
            let allGenres: Set<Genre> = Set(tracks.compactMap { $0.genre })
            
            for genre in allGenres {
                let tracks = tracks.filter { $0.genre == genre }
                rows.append(TrackRow(title: genre.rawValue.capitalized,
                                     tracks: tracks))
            }
            
            trackRows = rows
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
            ForEach(recentTracks, id: \.self) { track in
                RecentsCell(imageName: track.albumCover,
                            title: track.trackName)
                .asButton(.press) {
                    navigateToPlaylistView(track: track)
                }
            }
        }
    }
    
    private func navigateToPlaylistView(track: Track) {
        guard let currentUser else { return }
        
        router.showScreen { _ in
            PlaylistView(track: track, user: currentUser)
        }
    }
    
    private func newReleaseSection(track: Track) -> some View {
        NewReleaseCell(imageName: track.albumCover,
                       headline: track.artist,
                       subHeadline: track.album,
                       title: track.trackName,
                       subtitle: track.genre.rawValue.capitalized,
                       onAddToPlaylistPressed: {
            
        }, onPlayPressed: {
            navigateToPlaylistView(track: track)
        })
    }
    
    private var featuredSection: some View {
        ForEach(trackRows) { row in
            VStack(spacing: 8) {
                Text(row.title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.themeWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
               
                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 16) {
                        ForEach(row.tracks) { track in
                            ImageTitleRowCell(imageSize: 120,
                                              imageName: track.albumCover,
                                              title: track.trackName)
                            .asButton(.press) {
                                navigateToPlaylistView(track: track)
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
