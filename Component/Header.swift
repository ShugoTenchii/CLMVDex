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
                ClickableSVG(svgName: EnumAssets.pokeball.path) {
                    print("SVG cliqué !")
                }
                .frame(width: 100, height: 100)
                ThemeToggle()
            }
        }
    }
}

