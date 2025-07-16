//
//  View+Extensions.swift
//  SwiftUI-Layout-Practice1
//
//  Created by Jansen Ducusin on 7/16/25.
//

import SwiftUI

extension View {
    func themeColors(isSelected: Bool) -> some View {
        self
            .background(isSelected ? .themeGreen : .themeDarkGray)
            .foregroundStyle(isSelected ? .themeBlack : .themeWhite)
    }
}
