//
//  Facade.swift
//  CLMVDex
//
//  Created by ShugoTenchi on 06/01/2025.
//

import PokemonAPI

class Facade {
    static let shared = Facade()
    
    private let service = PokemonService()
    private let favoriteManager = FavoritePokemonManager()
    
    /// Récupère la liste complète des Pokémon depuis l'API
    func getAllPokemon() async throws -> [PKMPokemon] {
        return try await service.fetchAllPokemon()
    }
    
    /// Recherche des Pokémon par nom ou partie de nom
    func searchPokemon(by query: String, existingPokemon: [PKMPokemon]) async throws -> [PKMPokemon] {
        return await service.searchPokemon(by: query, existingPokemon: existingPokemon)
    }

    /// Ajoute un Pokémon aux favoris
    func addPokemonToFavorites(byId id: Int) async throws {
        let pokemon = try await service.fetchPokemon(byId: id)
        favoriteManager.addFavorite(from: pokemon)
    }

    /// Supprime un Pokémon des favoris
    func removePokemonFromFavorites(byId id: Int) {
        favoriteManager.removeFavorite(byId: id)
    }
    
    /// Récupère la liste des favoris depuis le stockage local
    func getFavorites() -> [FavoritePokemon] {
        return favoriteManager.getFavorites()
    }
    
    /// Récupère les détails d'un Pokémon favori via l'API
    func getFavoriteDetails(byId id: Int) async throws -> PKMPokemon {
        return try await service.fetchPokemon(byId: id)
    }

    func getPokemonById(byId id: Int) async throws -> PKMPokemon{
        return try await service.fetchPokemon(byId: id)
    }

    func getPaginatedPokemon(offset: Int, limit: Int) async throws -> [PKMPokemon] {
        return try await service.fetchPokemonByPage(offset: offset, limit: limit)
    }

}
