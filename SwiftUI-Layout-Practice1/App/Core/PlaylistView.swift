//
//  PlaylistView.swift
//  SwiftUI-Layout-Practice1
//
//  Created by Jansen Ducusin on 7/17/25.
//

import SwiftUI

struct PlaylistView: View {
    var track: Track = .mock
    var user: User = .mock
    
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
            }
            .scrollIndicators(.hidden)
            

        }
    }
}

#Preview {
    PlaylistView()
}
