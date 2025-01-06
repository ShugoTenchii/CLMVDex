//
//  Header.swift
//  CLMVDex
//
//  Created by ShugoTenchi on 05/01/2025.
//

import SwiftUI

struct Header: View {
    var pokemonFacade: Facade
    @Binding var path: [EnumPage] // Référence à la pile de navigation
    @State private var isDarkMode = false
    @State private var showMenu = false

    var body: some View {
        ZStack(alignment: .topLeading) {
            HStack {
                ClickableSVG(svgName: EnumAssets.pokeball.rawValue, height: 37.5, weight: 37.5) {
                    withAnimation {
                        showMenu.toggle() // Affiche ou cache le menu
                    }
                }
                Spacer()
                ThemeToggle()
            }
            .padding()
            .background(Color("Background"))

            if showMenu {
                ZStack() {
                    Button(action: {
                        withAnimation {
                            path.append(.mesFavoris) // Navigue vers "Mes Favoris"
                            showMenu = false
                        }
                    }) {
                        Text("Mes Favoris")
                            .font(Font.custom("Jost", size: 16))
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(Color(EnumColor.background.rawValue))
                            .cornerRadius(10)
                    }
                }
                .zIndex(3)
                .offset(x: 0, y: 50) 
            }
        }
    }
}
