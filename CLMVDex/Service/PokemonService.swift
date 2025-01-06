//
//  PokemonService.swift
//  CLMVDex
//
//  Created by ShugoTenchi on 06/01/2025.
//

import PokemonAPI
import Foundation

class PokemonService {
    private let api = PokemonAPI()

    /// Récupère la liste complète des Pokémon, paginée
    func fetchAllPokemon() async throws -> [PKMNamedAPIResource<PKMPokemon>] {
        var allPokemon: [PKMNamedAPIResource<PKMPokemon>] = []

        // Charger la première page
        var pagedResult = try await api.pokemonService.fetchPokemonList(paginationState: .initial(pageLimit: 100))

        // Ajouter les résultats de la première page
        if let results = pagedResult.results as? [PKMNamedAPIResource<PKMPokemon>] {
            allPokemon.append(contentsOf: results)
        }

        // Parcourir les pages suivantes tant que hasNext est vrai
        while pagedResult.hasNext {
            pagedResult = try await api.pokemonService.fetchPokemonList(
                paginationState: .continuing(pagedResult, .next)
            )
            if let results = pagedResult.results as? [PKMNamedAPIResource<PKMPokemon>] {
                allPokemon.append(contentsOf: results)
            }
        }

        return allPokemon
    }

    /// Récupère un Pokémon spécifique par son ID
    func fetchPokemon(byId id: Int) async throws -> PKMPokemon {
        return try await api.pokemonService.fetchPokemon(id)
    }

    /// Récupère un Pokémon spécifique par son nom
    func fetchPokemon(byName name: String) async throws -> PKMPokemon {
        return try await api.pokemonService.fetchPokemon(name)
    }

    /// Recherche des Pokémon par mot-clé
    func searchPokemon(by query: String) async throws -> [PKMNamedAPIResource<PKMPokemon>] {
        let allPokemon = try await fetchAllPokemon()
        return allPokemon.filter { $0.name?.lowercased().contains(query.lowercased()) ?? false }
    }
}
