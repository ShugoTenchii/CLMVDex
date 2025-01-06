//
//  ContentView.swift
//  CLMVDex
//
//  Created by ShugoTenchi on 25/12/2024.
//

import SwiftUI

struct MesFavoris: View {
    @Binding var path: [EnumPage]
    var pokemonFacade : Facade
    var body: some View {
        var pokemonList = pokemonFacade.getPokemonList()
        VStack {
            HStack {
                Text("Mes Pokémon Favoris")
                    .font(Font.custom("Jost", size: 35))
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 12)

            ScrollView { // Permet de scroller la liste des cartes
                VStack(spacing: 20) {
                    ForEach(pokemonList, id: \.id) { pokemon in
                        MylittleCard(frameWidth: .infinity, frameHeight: 90) {
                            HStack {
                                if let imageName = pokemon.image {
                                    Image(imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 90, height: 90)
                                } else {
                                    Image(EnumAssets.pokeball.rawValue)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 90, height: 90)
                                }

                                Spacer()
                                
                                VStack{
                                    HStack{
                                        Spacer()
                                        Text("\(pokemon.id) - \(pokemon.name)")
                                            .font(Font.custom("Jost", size: 20))
                                    }
                                    .padding(.horizontal, 20)
                                    HStack{
                                        Spacer()
                                        TypesView(Type1: pokemon.type1, Type2: pokemon.type2 ?? "")
                                    }
                                    .padding(.horizontal, 20)
                                }
                            }
                            .padding(.horizontal, 12)
                            .frame(maxWidth: .infinity, maxHeight: 90)
                        }
                    }
                }
                .padding(.horizontal, 12)
                .padding(.top, 20)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, 15)
        .background(Color("Background"))
    }
}

