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
                Color.clear
                    .frame(width: 1, height: 1)
                    .modifier(DetectIsOnScreen())
                    .onPreferenceChange(IsOnScreenKey.self) { isVisible in
                        if isVisible == true {
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
                MylittleCard(frameWidth: 90, frameHeight: 90) {
                    AsyncImage(url: URL(string: pokemon.sprites?.frontDefault ?? ""))
                        .scaledToFit()
                        .frame(width: 87, height: 87)
                }
                .shadow(color: Color(EnumColor.shadow2.rawValue), radius: 9, x: -9, y: -9)
                .shadow(color: Color(EnumColor.shadow1.rawValue), radius: 9, x: 9, y: 9)
            }
            Text("\(pokemon.id ?? 0) - \(pokemon.name ?? "Inconnu")")
                .font(Font.custom("Jost", size: 12))
                .lineLimit(1)
        }
        .frame(width: 90, height: 150)
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
                    value: reader.frame(in: .global).maxX >= 0 && reader.frame(in: .global).minX <= UIScreen.main.bounds.width
                )
        }
    }
}
