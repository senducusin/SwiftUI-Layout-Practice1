//
//  RecentsCell.swift
//  SwiftUI-Layout-Practice1
//
//  Created by Jansen Ducusin on 7/16/25.
//

import SwiftUI

struct RecentsCell: View {
    var imageName = Constants.randomImage
    var title = "Random Title"
    
    var body: some View {
        HStack(spacing: 16) {
            ImageLoaderView(urlString: imageName)
                .frame(width: 55, height: 55)
            
            Text(title)
                .font(.callout)
                .fontWeight(.semibold)
                .lineLimit(2)
            
            Spacer()

        }
        .foregroundStyle(.white)
//        .padding(.trailing, 8)
        .themeColors(isSelected: false)
        .cornerRadius(6)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        VStack {
            HStack {
                RecentsCell()
                RecentsCell()
            }
            
            HStack {
                RecentsCell()
                RecentsCell()
            }
        }
    }
}
