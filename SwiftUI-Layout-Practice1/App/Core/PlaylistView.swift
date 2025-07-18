//
//  PlaylistView.swift
//  SwiftUI-Layout-Practice1
//
//  Created by Jansen Ducusin on 7/17/25.
//

import SwiftUI
import SwiftfulUI

struct PlaylistView: View {
    var track: Track = .mock
    var user: User = .mock
    var genre: Genre = .rock
    
    @State private var tracks = [Track]()
    @State private var showHeader: Bool = true
    
    var body: some View {
        ZStack {
            Color.themeBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 12) {
                    PlaylistHeaderCell(
                        height: 250,
                        title: track.trackName,
                        subtitle: track.artist,
                        imageName: track.albumCover
                    )
                    .readingFrame { frame in
                        showHeader = frame.maxY < 120
                    }
                }
                
                PlaylistDescriptionCell(descriptionText: track.album,
                                        username: user.username,
                                        subheadline: track.genre.rawValue.capitalized,
                                        onAddToPlaylistPressed: {},
                                        onDownloadPressed: {},
                                        onSharePressed: {},
                                        onMorePressed: {},
                                        onShuffleressed: {},
                                        onPlayPressed: {})
                .padding(.horizontal, 16)
                
                ForEach(tracks) { track in
                    SongRowCell(
                        imageSize: 50,
                        imageName: track.albumCover,
                        title: track.trackName,
                        subtitle: track.artist,
                        onCellPressed: {
                            
                        },
                        onMorePressed: {
                            
                        }
                    )
                    .padding(.horizontal, 16)
                }
            }
            .scrollIndicators(.hidden)
            
            ZStack {
                Text(track.trackName)
                    .font(.headline)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .offset(y: showHeader ? 0 : -40)
                    .background(Color.themeBlack)
                    .opacity(showHeader ? 1 : 0)
                
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .padding(10)
                    .background(showHeader ? Color.themeGray.opacity(0.001) : Color.themeGray.opacity(0.7))
                    .clipShape(Circle())
                    .onTapGesture {
                        
                    }
                    .padding(.leading, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .foregroundStyle(.themeWhite)
            .animation(.smooth(duration: 0.2), value: showHeader)
            .frame(maxHeight: .infinity, alignment: .top)
        
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private func getData() async {
        do {
            tracks = try await MockDataHelper().getTracks(by: genre)
        } catch { }
    }
}

#Preview {
    PlaylistView()
}
