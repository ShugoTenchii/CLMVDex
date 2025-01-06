//
//  ContentView.swift
//  CLMVDex
//
//  Created by ShugoTenchi on 25/12/2024.
//

import SwiftUI

struct MainMenu: View {
    @Binding var path: [EnumPage]
    @State private var filteredPokemonList: [Pokemon] = []
    @State private var searchText: String = ""
    @State private var pokemonId: Int = 1
    var pokemonFacade : Facade
    var body: some View {
        VStack {
            FirstCard()
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
            VStack{
                SearchBar{query in
                    searchText = query
                    filteredPokemonList = pokemonFacade.getPokemonList()
                    updateFilteredList(query: query)
                }
                CarouselView(pokemonList: filteredPokemonList){
                    selectedId in pokemonId = selectedId
                }
                .padding(.top, 15)
            }
            .padding(.top, 15)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, 10)
        .padding(.bottom, 20)
        .background(Color("Background"))
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            filteredPokemonList = pokemonFacade.getPokemonList()
        }
    }
    
    private func FirstCard() -> some View {
            MyCard(frameWidth: 0, frameHeight: 320){
                HStack{
                    Text(String(pokemonFacade.getPokemon(id: pokemonId)?.id ?? 0) + " - " + pokemonFacade.getPokemon(id: pokemonId)!.name)
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
    }
    
    private func updateFilteredList(query: String) {
        if query.isEmpty {
            filteredPokemonList = pokemonFacade.getPokemonList()
        } else {
            filteredPokemonList = pokemonFacade.searchPokemon(name: query)
        }
    }
}

