//
//  Carousel.swift
//  CLMVDex
//
//  Created by ShugoTenchi on 06/01/2025.
//

import SwiftUI
import PokemonAPI

struct CarouselView: View {
    var pokemonList: [PKMPokemon] // Liste de PKMPokemon
    var onSelect: (PKMPokemon) -> Void // Callback pour sélectionner un Pokémon

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                if pokemonList.isEmpty {
                    Text("Aucun résultat trouvé")
                        .font(Font.custom("Jost", size: 16))
                        .foregroundColor(Color(EnumColor.noBackground.rawValue))
                        .padding(.top, 5)
                        .padding(.bottom, 20)
                } else {
                    ForEach(pokemonList, id: \.id) { pokemon in
                        pokemonCard(for: pokemon)
                    }
                }
            }
            .padding(.horizontal, 12)
        }
    }

    private func pokemonCard(for pokemon: PKMPokemon) -> some View {
        VStack {
            Button(action: {
                onSelect(pokemon) // Retourne l'objet PKMPokemon sélectionné
            }) {
                MylittleCard(frameWidth: 90, frameHeight: 90) {
//                    Image(EnumAssets.pokeball.rawValue)
//                        .resizable()
                    AsyncImage(url: URL(string: pokemon.sprites?.frontDefault ?? ""))
                        .scaledToFit()
                        .frame(width: 90, height: 90)
                }
                .shadow(color: Color(EnumColor.shadow2.rawValue), radius: 9, x: -9, y: -9)
                .shadow(color: Color(EnumColor.shadow1.rawValue), radius: 9, x: 9, y: 9)
            }
            Text("\(pokemon.id ?? 0) - \(pokemon.name ?? "Inconnu")")
                .font(Font.custom("Jost", size: 12))
        }
        .frame(width: 90)
    }
}
