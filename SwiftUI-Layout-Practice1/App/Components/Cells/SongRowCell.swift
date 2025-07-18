//
//  SongRowCell.swift
//  SwiftUI-Layout-Practice1
//
//  Created by Jansen Ducusin on 7/18/25.
//

import SwiftUI

struct SongRowCell: View {
    var imageSize: CGFloat = 50
    var imageName: String = Constants.randomImage
    var title: String = "Some song name"
    var subtitle: String = "Some artist name"
    
    var onCellPressed: (() -> Void)? = nil
    var onMorePressed: (() -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 8) {
            ImageLoaderView(urlString: imageName)
                .frame(width: imageSize, height: imageSize)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundStyle(.themeWhite)
                
                Text(subtitle)
                    .font(.callout)
                    .foregroundStyle(.themeLightGray)
            }
            .lineLimit(2)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "ellipsis")
                .font(.subheadline)
                .foregroundStyle(.themeWhite)
                .padding(16)
                .onTapGesture {
                    onMorePressed?()
                }
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        VStack {
            SongRowCell()
            SongRowCell()
            SongRowCell()
            SongRowCell()
        }
        .foregroundStyle(Color.red)
    }
}
