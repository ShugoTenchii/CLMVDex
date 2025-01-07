//
//  MainMenuViewModel.swift
//  CLMVDex
//
//  Created by Luka DA COSTA on 07/01/2025.
//

import Foundation
import Combine
import PokemonAPI

@MainActor
class MainMenuViewModel: ObservableObject {
    @Published var allPokemonList: [PKMPokemon] = [] // Liste complète de Pokémon
    @Published var filteredPokemonList: [PKMPokemon] = [] // Liste filtrée de Pokémon
    @Published var selectedPokemon: PKMPokemon? // Pokémon actuellement sélectionné
    @Published var searchText: String = "" // Texte de recherche
    @Published var isLoading: Bool = false // Indicateur de chargement

    public let pokemonFacade: Facade
    private var currentOffset: Int = 0
    private let pageSize: Int = 20

    init(pokemonFacade: Facade) {
        self.pokemonFacade = pokemonFacade
    }

    /// Chargement initial des Pokémon
    func loadInitialPokemon() async {
        guard allPokemonList.isEmpty else { return } // Ne recharge pas si déjà chargé

        do {
            isLoading = true
            let pokemonResources = try await pokemonFacade.getPaginatedPokemon(offset: 0, limit: pageSize)
            allPokemonList = pokemonResources
            filteredPokemonList = pokemonResources
            currentOffset = pokemonResources.count

            if let firstPokemon = pokemonResources.first {
                selectedPokemon = firstPokemon
            }
        } catch {
            print("Erreur lors du chargement initial : \(error)")
        }
        isLoading = false
    }

    /// Chargement des Pokémon supplémentaires
    func loadMorePokemon() async {
        guard !isLoading else { return }

        isLoading = true
        defer { isLoading = false }

        do {
            let newPokemon = try await pokemonFacade.getPaginatedPokemon(offset: currentOffset, limit: pageSize)
            let uniquePokemon = newPokemon.filter { newPokemon in
                !allPokemonList.contains { $0.id == newPokemon.id }
            }

            if !uniquePokemon.isEmpty {
                allPokemonList.append(contentsOf: uniquePokemon)
                filteredPokemonList = allPokemonList
                currentOffset += uniquePokemon.count
            }
        } catch {
            print("Erreur lors du chargement des Pokémon supplémentaires : \(error)")
        }
    }

    /// Recherche de Pokémon par texte
    func updateFilteredList(query: String) async {
        guard !query.isEmpty else {
            filteredPokemonList = allPokemonList
            return
        }

        do {
            isLoading = true
            let results = try await pokemonFacade.searchPokemon(by: query, existingPokemon: allPokemonList)
            filteredPokemonList = results
        } catch {
            print("Erreur lors de la recherche de Pokémon : \(error)")
        }
        isLoading = false
    }

    /// Sélection d'un Pokémon
    func selectPokemon(pokemon: PKMPokemon) {
        selectedPokemon = pokemon
    }
}


