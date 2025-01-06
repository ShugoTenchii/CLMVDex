//
//  FavoritePokemonManager.swift
//  CLMVDex
//
//  Created by Luka DA COSTA on 06/01/2025.
//

import Foundation
import PokemonAPI

class FavoritePokemonManager {
    private let userDefaultsKey = "favoritePokemonList"
    
    // Récupérer les favoris
    func getFavorites() -> [FavoritePokemon] {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey),
              let favorites = try? JSONDecoder().decode([FavoritePokemon].self, from: data) else {
            return []
        }
        return favorites
    }

    // Ajouter un favori
    func addFavorite(from pokemon: PKMPokemon) {
        var favorites = getFavorites()
        if !favorites.contains(where: { $0.id == pokemon.id }) {
            let favorite = FavoritePokemon(
                id: pokemon.id ?? 0,
                name: pokemon.name ?? "Unknown",
                type: pokemon.types?.first?.type?.name ?? "Unknown"
            )
            favorites.append(favorite)
            saveFavorites(favorites)
        }
    }

    // Supprimer un favori
    func removeFavorite(byId id: Int) {
        var favorites = getFavorites()
        favorites.removeAll { $0.id == id }
        saveFavorites(favorites)
    }

    // Sauvegarder les favoris
    private func saveFavorites(_ favorites: [FavoritePokemon]) {
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        }
    }
}
