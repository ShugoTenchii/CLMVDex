//
//  PokemonService.swift
//  CLMVDex
//
//  Created by ShugoTenchi on 06/01/2025.
//

import PokemonAPI
import Foundation

protocol PokemonServiceProtocol {
    func fetchPokemonList() async throws -> [PKMNamedAPIResource<PKMPokemon>]
    func fetchPokemon(by name: String) async throws -> PKMPokemon
    func searchPokemon(by query: String) async throws -> [PKMNamedAPIResource<PKMPokemon>]
    func savePokemon(name: String) async throws -> Pokemon
}

class PokemonService: PokemonServiceProtocol {
    private let api = PokemonAPI()

    /// Récupère la liste complète des Pokémon depuis l'API.
    func fetchPokemonList() async throws -> [PKMNamedAPIResource<PKMPokemon>] {
        // Assurez-vous que cette méthode retourne des PKMNamedAPIResource<PKMPokemon>
        let pagedResult = try await api.pokemonService.fetchPokemonList(paginationState: .initial(pageLimit: 100))
        guard let results = pagedResult.results as? [PKMNamedAPIResource<PKMPokemon>] else {
            throw NSError(domain: "PokemonService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid type returned from API."])
        }
        return results
    }

    /// Récupère les détails d'un Pokémon spécifique par son nom.
    func fetchPokemon(by name: String) async throws -> PKMPokemon {
        return try await api.pokemonService.fetchPokemon(name)
    }

    /// Recherche des Pokémon dont le nom contient une sous-chaîne donnée.
    func searchPokemon(by query: String) async throws -> [PKMNamedAPIResource<PKMPokemon>] {
        let allPokemon = try await fetchPokemonList()
        return allPokemon.filter { $0.name?.contains(query.lowercased()) ?? false }
    }

    /// Sauvegarde un Pokémon spécifique par son nom.
    func savePokemon(name: String) async throws -> Pokemon {
        let pokemon = try await fetchPokemon(by: name)
        
        // Simplifie les types pour n'en conserver qu'un seul (le premier)
        let primaryType = pokemon.types?.first?.type?.name ?? "Unknown"
        
        return Pokemon(id: pokemon.id ?? 0, name: pokemon.name ?? "Unknown", type: primaryType)
    }
}
