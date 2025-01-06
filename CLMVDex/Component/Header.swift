//
//  Header.swift
//  CLMVDex
//
//  Created by ShugoTenchi on 05/01/2025.
//

import SwiftUI

struct Header: View {
    var pokemonFacade : Facade
    @State private var isDarkMode = false
    @State private var showMenu = false
    
    var body: some View {
        ZStack {
            HStack{
                ClickableSVG(svgName: EnumAssets.pokeball.rawValue, height: 37.5, weight: 37.5) {
                    withAnimation {
                        showMenu.toggle()
                    }
                }
                Spacer()
                ThemeToggle()
            }
            .background(Color("Background"))
            
            if showMenu {
                    VStack(alignment: .leading, spacing: 30) {
                        NavigationLink(destination: MesFavoris(pokemonFacade: pokemonFacade)) {
                            Text("Mes Favoris")
                                .font(Font.custom("Jost", size: 16))
                                .padding(.vertical, 8)
                                .padding(.horizontal, 12)
                                .background(Color.white)
                                .cornerRadius(10)
                        }
                        
                        NavigationLink(destination: Text("Autre Page")) {
                            Text("Autre Option")
                                .font(Font.custom("Jost", size: 16))
                                .padding(.vertical, 8)
                                .padding(.horizontal, 12)
                                .background(Color.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("Background"))
                    )
                    .offset(x: 0, y: 50)
            }
        }
    }
}

