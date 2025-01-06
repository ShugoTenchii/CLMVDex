//
//  Carousel.swift
//  CLMVDex
//
//  Created by ShugoTenchi on 06/01/2025.
//

import SwiftUI

struct CarouselView: View {
    var pokemonList : [Pokemon]
    var onSelect: (Int) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                if pokemonList.isEmpty {
                                    Text("Aucun résultat trouvé")
                                        .font(Font.custom("Jost", size: 16))
                                        .foregroundColor(Color(EnumColor.noBackground.rawValue))
                                        .padding(.top, 5)
                } else {
                    ForEach(pokemonList, id: \.id) { pokemon in
                        pokemonCard(for: pokemon)
                    }
                }
            }
            .padding(.horizontal, 12)
            .edgesIgnoringSafeArea(.all)
        }
    }
    private func pokemonCard(for pokemon : Pokemon) -> some View{
        VStack {
            Button(action: {
                onSelect(pokemon.id) // Retourne l'ID du Pokémon sélectionné
            }) {MylittleCard(frameWidth: 90, frameHeight: 90) {
                Image(EnumAssets.pokeball.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                    .foregroundColor(Color(EnumColor.noBackground.rawValue))
            }
            }
            Text(String(pokemon.id) + " - " + pokemon.name)
                .font(Font.custom("Jost", size: 12))
        }
        .frame(width: 90)
    }
}
