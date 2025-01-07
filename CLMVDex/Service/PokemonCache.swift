//
//  PokemonCache.swift
//  CLMVDex
//
//  Created by Luka DA COSTA on 06/01/2025.
//

import Foundation
import PokemonAPI

class PokemonCache {
    private let cacheFileName = "pokemonCache.json"
    private let cacheMetadataKey = "pokemonCacheMetadata"

    // MARK: - Fichiers
    private func getCacheFileURL() -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent(cacheFileName)
    }

    // MARK: - Métadonnées
    func isCacheUpToDate(expectedCount: Int) -> Bool {
        let metadata = UserDefaults.standard.dictionary(forKey: cacheMetadataKey)
        let cachedCount = metadata?["count"] as? Int ?? 0
        return cachedCount == expectedCount
    }

    func updateCacheMetadata(count: Int) {
        let metadata: [String: Any] = [
            "count": count,
            "lastUpdated": Date().timeIntervalSince1970
        ]
        UserDefaults.standard.set(metadata, forKey: cacheMetadataKey)
    }

    // MARK: - Sauvegarde
    func saveToCache(_ pokemonList: [PKMPokemon]) {
        let fileURL = getCacheFileURL()
        do {
            let jsonData = try JSONEncoder().encode(pokemonList)
            try jsonData.write(to: fileURL, options: .atomic)
            print("Données mises en cache avec succès.")
        } catch {
            print("Erreur lors de la sauvegarde en cache : \(error)")
        }
    }

    // MARK: - Chargement
    func loadFromCache() -> [PKMPokemon]? {
        let fileURL = getCacheFileURL()
        do {
            let jsonData = try Data(contentsOf: fileURL)
            let pokemonList = try JSONDecoder().decode([PKMPokemon].self, from: jsonData)
            return pokemonList
        } catch {
            print("Erreur lors de la lecture du cache : \(error)")
            return nil
        }
    }

    func clearCache() {
        let fileURL = getCacheFileURL()
        do {
            try FileManager.default.removeItem(at: fileURL)
            UserDefaults.standard.removeObject(forKey: cacheMetadataKey)
            print("Cache effacé avec succès.")
        } catch {
            print("Erreur lors de la suppression du cache : \(error)")
        }
    }
}
