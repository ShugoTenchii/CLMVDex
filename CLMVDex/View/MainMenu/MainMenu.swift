//
//  ContentView.swift
//  CLMVDex
//
//  Created by ShugoTenchi on 25/12/2024.
//

import SwiftUI

struct MainMenu: View {
    var pokemonFacade : Facade
    var pokemonId = 1
    var body: some View {
        VStack {
            MyCard(frameWidth: 0, frameHeight: 320){
                HStack{
                    Text(pokemonFacade.getPokemon(id: pokemonId)?.name ?? "None")
                        .font(Font.custom("Jost", size: 20))
                        
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 30)
                Spacer()
                Image(pokemonFacade.getPokemon(id: pokemonId)?.image ?? EnumAssets.pokeball.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                Spacer()
                HStack{
                    Spacer()
                    TypesView(Type1: pokemonFacade.getPokemon(id: pokemonId)?.type1 ?? "1", Type2: pokemonFacade.getPokemon(id: pokemonId)?.type2 ?? "1")
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 30)
            }
            Spacer()
            HStack{
                Spacer()
                Button(action: {
                    print("Ajouter au Favoris")
                }) {
                    Image(EnumAssets.add.rawValue)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                }
                .buttonStyle(MyButtonStyle())
            }
            Spacer()
            EvolutionCard(
                asMega: pokemonFacade.getPokemon(id: pokemonId)?.asMega ?? false
            )
            Spacer()
            SearchBar{ query in
                pokemonFacade.searchPokemon(name: query)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, 15)
        .padding(.bottom, 20)
        .background(Color("Background"))
        .edgesIgnoringSafeArea(.all)
    }
}

