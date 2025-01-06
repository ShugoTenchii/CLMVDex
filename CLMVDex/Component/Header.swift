//
//  Header.swift
//  CLMVDex
//
//  Created by ShugoTenchi on 05/01/2025.
//

import SwiftUI

struct Header: View {
    var pokemonFacade: Facade
    @Binding var path: [EnumPage]
    @State private var isDarkMode = false
    @State private var showMenu = false

    var body: some View {
        ZStack {
            // Contenu principal
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
            .background(Color(EnumColor.background.rawValue).opacity(0))
            .zIndex(0)

            // Menu par-dessus tout
            if showMenu {
                Color.black.opacity(0)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                            showMenu = false
                    }
                    .zIndex(0)

                VStack {
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
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 150)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color(EnumColor.background.rawValue))
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: [Color(EnumColor.strokes2.rawValue), Color(EnumColor.strokes1.rawValue)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 2
                        )
                )
                .cornerRadius(30)
                .zIndex(3)
                .offset(x: 0, y: 85)
            }
        }
        .zIndex(2) // Le Header reste visible derrière le menu
    }
}
