//
//  Header.swift
//  CLMVDex
//
//  Created by ShugoTenchi on 05/01/2025.
//

import SwiftUI

struct Header: View {
    @State private var isDarkMode = false
    
    var body: some View {
        ZStack {
            HStack{
                ClickableSVG(svgName: EnumAssets.pokeball.rawValue, height: 37.5, weight: 35.7) {
                    print("SVG cliqué !")
                }
                Spacer()
                ThemeToggle()
            }
        }
    }
}

