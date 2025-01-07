//
//  MesFavorisViewModel.swift
//  CLMVDex
//
//  Created by Luka DA COSTA on 07/01/2025.
//

import Foundation
import PokemonAPI

class MesFavorisViewModel: ObservableObject {
    @Published var favoritePokemons: [PKMPokemon] = []
    @Published var isLoading: Bool = true

    private let pokemonFacade: Facade

    init(pokemonFacade: Facade) {
        self.pokemonFacade = pokemonFacade
        loadFavorites()
    }

    func loadFavorites() {
        Task {
            await fetchFavorites()
        }
    }

    private func fetchFavorites() async {
        DispatchQueue.main.async {
            self.isLoading = true
        }

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

    private func fetchPokemonDetails(from ids: [Int]) async throws -> [PKMPokemon] {
        var results: [PKMPokemon] = []
        try await withThrowingTaskGroup(of: PKMPokemon?.self) { group in
            for id in ids {
                group.addTask {
                    return try? await self.pokemonFacade.getFavoriteDetails(byId: id)
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

    func removeFavoritePokemon(byId id: Int) {
        pokemonFacade.removePokemonFromFavorites(byId: id)
        favoritePokemons.removeAll { $0.id == id }
    }
}
