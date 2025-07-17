//
//  PlaylistHeaderCell.swift
//  SwiftUI-Layout-Practice1
//
//  Created by Jansen Ducusin on 7/17/25.
//

import SwiftUI
import SwiftfulUI

struct PlaylistHeaderCell: View {
    var height: CGFloat = 300
    var title: String = "Some playlist title"
    var subtitle: String = "Subtitle here"
    var imageName: String = Constants.randomImage
    var shadowColor: Color = .themeBlack.opacity(0.8)
    
    var body: some View {
        Rectangle()
            .opacity(0)
            .overlay {
                ImageLoaderView(urlString: imageName)
            }
            .overlay(
                VStack(alignment: .leading, spacing: 8) {
                    Text(subtitle)
                        .font(.headline)
                    
                    Text(title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                    .foregroundStyle(.themeWhite)
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        LinearGradient(colors: [shadowColor.opacity(0), shadowColor], startPoint: .top, endPoint: .bottom)
                    )
                
                ,alignment: .bottomLeading
            )
            .asStretchyHeader(startingHeight: height)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        ScrollView {
            PlaylistHeaderCell()
        }
        .ignoresSafeArea()
    }
}
