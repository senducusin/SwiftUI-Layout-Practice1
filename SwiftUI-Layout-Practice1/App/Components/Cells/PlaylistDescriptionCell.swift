//
//  PlaylistDescriptionCell.swift
//  SwiftUI-Layout-Practice1
//
//  Created by Jansen Ducusin on 7/18/25.
//

import SwiftUI

struct PlaylistDescriptionCell: View {
    var descriptionText: String = Track.mock.album
    var username: String = "Sen"
    var subheadline: String = "Some headline goes here"
    
    var onAddToPlaylistPressed: (() -> Void)? = nil
    var onDownloadPressed: (() -> Void)? = nil
    var onSharePressed: (() -> Void)? = nil
    var onMorePressed: (() -> Void)? = nil
    var onShuffleressed: (() -> Void)? = nil
    var onPlayPressed: (() -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(descriptionText)
                .foregroundStyle(.themeLightGray)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            madeForYouSection
            
            Text(subheadline)
            
            controlsSection
        }
        .font(.callout)
        .fontWeight(.medium)
        .foregroundStyle(.themeLightGray)
    }
    
    private var madeForYouSection: some View {
        HStack(spacing: 8) {
            Image(systemName: "applelogo")
                .font(.title3)
                .foregroundStyle(.themeGreen)
            
            Text("Made for ")
            + Text(username)
                .bold()
                .foregroundStyle(.themeWhite)
        }
    }
    
    private var controlsSection: some View {
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                Image(systemName: "plus.circle")
                    .padding(8)
                    .onTapGesture {
                        onAddToPlaylistPressed?()
                    }
                    
                Image(systemName: "arrow.down.circle")
                    .padding(8)
                    .onTapGesture {
                        onDownloadPressed?()
                    }
                Image(systemName: "square.and.arrow.up")
                    .padding(8)
                    .onTapGesture {
                        onSharePressed?()
                    }
                Image(systemName: "ellipsis")
                    .padding(8)
                    .onTapGesture {
                        onMorePressed?()
                    }
            }
            .offset(x: -8)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 8) {
                Image(systemName: "shuffle")
                    .font(.system(size: 24))
                    .onTapGesture {
                        onShuffleressed?()
                    }
                
                Image(systemName: "play.circle.fill")
                    .font(.system(size: 46))
                    .onTapGesture {
                        onPlayPressed?()
                    }
            }
            .foregroundStyle(.themeGreen)
            
        }
        .font(.title2)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        PlaylistDescriptionCell()
            .padding()
    }
}
