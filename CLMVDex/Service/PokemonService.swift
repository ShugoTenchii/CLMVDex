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
    func fetchAllPokemon() async throws -> [PKMPokemon] {
        var pokemonResources: [PKMNamedAPIResource<PKMPokemon>] = []
        
        // Charger les métadonnées
        var pagedResult = try await api.pokemonService.fetchPokemonList(paginationState: .initial(pageLimit: 100))
        
        if let results = pagedResult.results as? [PKMNamedAPIResource<PKMPokemon>] {
            pokemonResources.append(contentsOf: results)
        }
        
        while pagedResult.hasNext {
            pagedResult = try await api.pokemonService.fetchPokemonList(
                paginationState: .continuing(pagedResult, .next)
            )
            if let results = pagedResult.results as? [PKMNamedAPIResource<PKMPokemon>] {
                pokemonResources.append(contentsOf: results)
            }
        }
        
        // Récupérer les détails pour chaque Pokémon
        return try await withThrowingTaskGroup(of: PKMPokemon?.self) { group in
            for resource in pokemonResources {
                if let id = resource.url?.pokemonIdFromURL() {
                    group.addTask {
                        return try? await self.api.pokemonService.fetchPokemon(id)
                    }
                }
            }
            
            var results: [PKMPokemon] = []
            for try await pokemon in group {
                if let pokemon = pokemon {
                    results.append(pokemon)
                }
            }
            
            // Trier par ID
            return results.sorted { $0.id ?? Int.max < $1.id ?? Int.max }
        }
    }


    /// Récupère un Pokémon spécifique par son ID
    func fetchPokemon(byId id: Int) async throws -> PKMPokemon {
        return try await api.pokemonService.fetchPokemon(id)
    }

    func searchPokemon(by query: String, existingPokemon: [PKMPokemon]) async -> [PKMPokemon] {
        // Filtrage local immédiat
        var localResults = existingPokemon.filter { $0.name?.lowercased().contains(query.lowercased()) ?? false }
        
        // Requête API pour des résultats supplémentaires
        do {
            let fetchedPokemon = try await fetchPokemon(byName: query.lowercased())
            
            // Ajouter le Pokémon récupéré s'il n'est pas déjà présent
            if !localResults.contains(where: { $0.id == fetchedPokemon.id }) {
                localResults.append(fetchedPokemon)
            }
        } catch {
            print("Erreur lors de la récupération du Pokémon via l'API : \(error)")
        }
        print(localResults)
        return localResults
    }


    /// Récupère un Pokémon spécifique par son nom
    func fetchPokemon(byName name: String) async throws -> PKMPokemon {
        return try await api.pokemonService.fetchPokemon(name)
    }

    
    // Service modifié pour la pagination
    func fetchPokemonByPage(offset: Int, limit: Int) async throws -> [PKMPokemon] {
        print("Appel API avec offset : \(offset), limite : \(limit)")
        
        // Récupérer tous les Pokémon disponibles jusqu'à l'offset + limite
        let pagedResult = try await api.pokemonService.fetchPokemonList(paginationState: .initial(pageLimit: offset + limit))
        guard let resources = pagedResult.results as? [PKMNamedAPIResource<PKMPokemon>] else {
            print("Aucun résultat trouvé pour offset \(offset)")
            return []
        }
        
        // Appliquer un filtre pour ne prendre que les éléments correspondant à l'offset
        let filteredResources = Array(resources.dropFirst(offset).prefix(limit))
        print("Résultats filtrés : \(filteredResources.count)")
        
        return try await withThrowingTaskGroup(of: PKMPokemon?.self) { group in
            for resource in filteredResources {
                if let id = resource.url?.pokemonIdFromURL() {
                    group.addTask {
                        return try? await self.api.pokemonService.fetchPokemon(id)
                    }
                }
            }
            
            var results: [PKMPokemon] = []
            for try await pokemon in group {
                if let pokemon = pokemon {
                    results.append(pokemon)
                }
            }
            
            print("Pokémon détaillés récupérés : \(results.count)")
            return results.sorted { $0.id ?? Int.max < $1.id ?? Int.max }
        }
    }


}
