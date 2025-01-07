//
//  ContentView.swift
//  CLMVDex
//
//  Created by ShugoTenchi on 25/12/2024.
//

import SwiftUI
import PokemonAPI

struct MainMenu: View {
    @Binding var path: [EnumPage]
    @StateObject private var viewModel: MainMenuViewModel

    init(path: Binding<[EnumPage]>, pokemonFacade: Facade) {
        self._path = path
        self._viewModel = StateObject(wrappedValue: MainMenuViewModel(pokemonFacade: pokemonFacade))
    }

    var body: some View {
        VStack {
            // Affichage du Pokémon sélectionné dans la grande carte
            if let pokemon = viewModel.selectedPokemon {
                FirstCard(pokemon: pokemon)
            } else {
                Text("Chargement en cours...")
                    .font(.headline)
            }

            Spacer()

            // Bouton d'ajout aux favoris
            HStack {
                Spacer()
                if let pokemon = viewModel.selectedPokemon {
                    Button(action: {
                        Task {
                            try? await viewModel.pokemonFacade.addPokemonToFavorites(byId: pokemon.id ?? 0)
                            print("Ajouté aux favoris : \(pokemon.name ?? "Inconnu")")
                        }
                    }) {
                        Image(EnumAssets.add.rawValue)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                    .buttonStyle(MyButtonStyle())
                }
            }
            .padding(.top, 15)

            Spacer()

            // Recherche et carrousel des Pokémon
            VStack {
                SearchBar { query in
                    Task {
                        await viewModel.updateFilteredList(query: query)
                    }
                }

                CarouselView(
                    pokemonList: viewModel.filteredPokemonList,
                    onSelect: { pokemon in
                        viewModel.selectPokemon(pokemon: pokemon)
                    },
                    onLoadMore: {
                        Task {
                            await viewModel.loadMorePokemon()
                        }
                    }
                )
                .padding(.top, 15)
            }
            .padding(.top, 15)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.vertical, 20)
        .background(Color("Background"))
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            Task {
                await viewModel.loadInitialPokemon()
            }
        }
    }

    private func FirstCard(pokemon: PKMPokemon) -> some View {
        MyCard(frameWidth: 0, frameHeight: 320) {
            VStack {
                HStack {
                    Text("\(pokemon.id ?? 0) - \(pokemon.name ?? "Inconnu")")
                        .font(Font.custom("Jost", size: 20))
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 30)

                Spacer()

                AsyncImage(url: URL(string: pokemon.sprites?.frontDefault ?? ""))
                    .scaledToFit()
                    .frame(width: 200, height: 200)

                Spacer()

                HStack {
                    Spacer()
                    let type1 = String(pokemon.types?.first?.type?.url?.typeIdFromURL() ?? 1)
                    let type2 = String(pokemon.types?.dropFirst().first?.type?.url?.typeIdFromURL() ?? 1)
                    TypesView(Type1: type1, Type2: type2)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 30)
            }
        }
    }
}
