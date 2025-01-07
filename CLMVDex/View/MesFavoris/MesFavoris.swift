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
    var pokemonFacade: Facade
    @State private var favoritePokemons: [PKMPokemon] = []
    @State private var isLoading = true

    var body: some View {
        VStack {
            HStack {
                Text("Mes Pokémon Favoris")
                    .font(Font.custom("Jost", size: 35))
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 12)

            if isLoading {
                ProgressView("Chargement des favoris...")
                    .padding(.top, 50)
            } else if favoritePokemons.isEmpty {
                Text("Vous n'avez pas encore ajouté de Pokémon aux favoris.")
                    .font(Font.custom("Jost", size: 18))
                    .foregroundColor(Color(EnumColor.noBackground.rawValue))
                    .padding(.top, 50)
            } else {
                List {
                    
                    ForEach(favoritePokemons, id: \.id) { pokemon in
                        pokemonRow(for: pokemon)
                            .frame(maxWidth: .infinity)
                    }
                    .listRowBackground(
                        Capsule()
                            .fill(Color(EnumColor.background.rawValue)))
                }
                .listStyle(PlainListStyle()) 
                .frame(maxWidth: .infinity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, 15)
        .background(Color("Background"))
        .onAppear {
            loadFavorites()
        }
    }


    private func pokemonImage(for pokemon: PKMPokemon) -> some View {
        if let spriteUrl = pokemon.sprites?.frontDefault,
           let uiImage = loadImage(from: spriteUrl) {
            return Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 90)
        } else {
            return Image(EnumAssets.pokeball.rawValue)
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 90)
        }
    }

    private func loadImage(from urlString: String) -> UIImage? {
        guard let url = URL(string: urlString),
              let imageData = try? Data(contentsOf: url) else {
            return nil
        }
        return UIImage(data: imageData)
    }

    private func loadFavorites() {
        Task {
            isLoading = true
            let favoriteIds = pokemonFacade.getFavorites().map { $0.id }
            do {
                let details = try await fetchPokemonDetails(from: favoriteIds)
                DispatchQueue.main.async {
                    self.favoritePokemons = details
                    self.isLoading = false
                }
            } catch {
                print("Erreur lors du chargement des favoris : \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.favoritePokemons = []
                    self.isLoading = false
                }
            }
        }
    }

    private func fetchPokemonDetails(from ids: [Int]) async throws -> [PKMPokemon] {
        var results: [PKMPokemon] = []
        try await withThrowingTaskGroup(of: PKMPokemon?.self) { group in
            for id in ids {
                group.addTask {
                    return try? await pokemonFacade.getFavoriteDetails(byId: id)
                }
            }

            for try await pokemon in group {
                if let pokemon = pokemon {
                    results.append(pokemon)
                }
            }
        }
        return results
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
                .frame( height: 90)
            }
            .shadow(color: Color(EnumColor.shadow2.rawValue), radius: 9, x: -9, y: -9)
            .shadow(color: Color(EnumColor.shadow3.rawValue), radius: 9, x: 9, y: 9)
            .frame(maxWidth: .infinity, maxHeight: 90)
            .swipeActions(edge: .trailing) {
                Button(role: .destructive) {
                    pokemonFacade.removePokemonFromFavorites(byId: pokemon.id!)
                } label: {
                    Label("Supprimé", systemImage: "trash")
                }
                .tint(.red)
            }
        }
    }

}
