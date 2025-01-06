//
//  Carousel.swift
//  CLMVDex
//
//  Created by ShugoTenchi on 06/01/2025.
//

import SwiftUI

struct CarouselView: View {
    var pokemonFacade : Facade
    var body: some View {
        var pokemonList = pokemonFacade.getPokemonList()
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(pokemonList, id: \.id) { card in
                    VStack {
                        MylittleCard(frameWidth: 90, frameHeight: 90) {
                            Image(EnumAssets.pokeball.rawValue)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 90, height: 90)
                                .foregroundColor(Color(EnumColor.noBackground.rawValue))
                        }
                        Text(card.name)
                            .font(Font.custom("Jost", size: 12))
                    }
                    .frame(width: 90)
                }
            }
            .padding(.horizontal, 12)
            .edgesIgnoringSafeArea(.all)
        }
    }
}
