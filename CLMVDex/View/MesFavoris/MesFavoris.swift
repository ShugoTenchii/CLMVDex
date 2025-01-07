//
//  MesFavoris.swift
//  CLMVDex
//
//  Created by ShugoTenchi on 25/12/2024.
//

import SwiftUI
import PokemonAPI

struct MesFavoris: View {
    @Binding var path: [EnumPage]
    @StateObject private var viewModel: MesFavorisViewModel

    init(path: Binding<[EnumPage]>, pokemonFacade: Facade) {
        self._path = path
        self._viewModel = StateObject(wrappedValue: MesFavorisViewModel(pokemonFacade: pokemonFacade))
    }

    var body: some View {
        VStack {
            HStack {
                Text("Mes Pokémon Favoris")
                    .font(Font.custom("Jost", size: 35))
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 12)

            if viewModel.isLoading {
                ProgressView("Chargement des favoris...")
                    .padding(.top, 50)
            } else if viewModel.favoritePokemons.isEmpty {
                Text("Vous n'avez pas encore ajouté de Pokémon aux favoris.")
                    .font(Font.custom("Jost", size: 18))
                    .foregroundColor(Color(EnumColor.noBackground.rawValue))
                    .padding(.top, 50)
            } else {
                List {
                    ForEach(viewModel.favoritePokemons, id: \.id) { pokemon in
                        pokemonRow(for: pokemon)
                            .frame(maxWidth: .infinity)
                    }
                    .listRowBackground(
                        Capsule()
                            .fill(Color(EnumColor.background.rawValue))
                    )
                }
                .listStyle(PlainListStyle())
                .frame(maxWidth: .infinity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, 15)
        .background(Color("Background"))
        .onAppear {
            viewModel.loadFavorites()
        }
    }

    private func pokemonRow(for pokemon: PKMPokemon) -> some View {
        MylittleCard(frameWidth: .infinity, frameHeight: 90) {
            HStack {
                AsyncImage(url: URL(string: pokemon.sprites?.frontDefault ?? ""))
                    .frame(width: 90, height: 90)
                Spacer()
                VStack {
                    HStack {
                        Spacer()
                        Text("\(pokemon.id ?? 0) - \(pokemon.name ?? "Inconnu")")
                            .font(Font.custom("Jost", size: 20))
                    }
                    .padding(.horizontal, 20)
                    HStack {
                        Spacer()
                        TypesView(
                            Type1: String(pokemon.types?.first?.type?.url?.typeIdFromURL() ?? 1),
                            Type2: String(pokemon.types?.dropFirst().first?.type?.url?.typeIdFromURL() ?? 1)
                        )
                    }
                    .padding(.horizontal, 20)
                }
                .frame(height: 90)
            }
            .shadow(color: Color(EnumColor.shadow2.rawValue), radius: 9, x: -9, y: -9)
            .shadow(color: Color(EnumColor.shadow3.rawValue), radius: 9, x: 9, y: 9)
            .frame(maxWidth: .infinity, maxHeight: 90)
            .swipeActions(edge: .trailing) {
                Button(role: .destructive) {
                    viewModel.removeFavoritePokemon(byId: pokemon.id!)
                } label: {
                    Label("Supprimé", systemImage: "trash")
                }
                .tint(.red)
            }
        }
    }
}
