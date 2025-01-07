//
//  Carousel.swift
//  CLMVDex
//
//  Created by ShugoTenchi on 06/01/2025.
//

import SwiftUI
import PokemonAPI

struct CarouselView: View {
    var pokemonList: [PKMPokemon]
    var onSelect: (PKMPokemon) -> Void
    var onLoadMore: () -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(pokemonList, id: \.id) { pokemon in
                    pokemonCard(for: pokemon)
                }

                // Vue invisible pour déclencher `onLoadMore`
                Color.clear
                    .frame(width: 1, height: 1)
                    .modifier(DetectIsOnScreen())
                    .onPreferenceChange(IsOnScreenKey.self) { isVisible in
                        if isVisible == true {
                            print("Dernier élément visible, déclenche onLoadMore")
                            onLoadMore()
                        }
                    }
            }
            .padding(.horizontal, 12)
        }
    }

    private func pokemonCard(for pokemon: PKMPokemon) -> some View {
        VStack {
            Button(action: {
                onSelect(pokemon)
            }) {
                AsyncImage(url: URL(string: pokemon.sprites?.frontDefault ?? ""))
                    .scaledToFit()
                    .frame(width: 90, height: 90)
            }
            Text("\(pokemon.id ?? 0) - \(pokemon.name ?? "Inconnu")")
                .font(Font.custom("Jost", size: 12))
        }
        .frame(width: 90)
    }
}


struct IsOnScreenKey: PreferenceKey {
    static let defaultValue: Bool? = nil
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        if let next = nextValue() {
            value = next
        }
    }
}

struct DetectIsOnScreen: ViewModifier {
    func body(content: Content) -> some View {
        GeometryReader { reader in
            content
                .preference(
                    key: IsOnScreenKey.self,
                    value: reader.frame(in: .global).maxX > UIScreen.main.bounds.width
                )
        }
    }
}
