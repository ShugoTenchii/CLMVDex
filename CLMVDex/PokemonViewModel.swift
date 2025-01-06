//
//  PokemonViewModel.swift
//  CLMVDex
//
//  Created by Luka DA COSTA on 06/01/2025.
//

import Foundation
import PokemonAPI

class PokemonViewModel: ObservableObject {
    @Published var pokemonName: String = "Loading..."
    @Published var pokemonImageURL: String = ""
    @Published var pokemonTypes: [(name: String, id: Int)] = [] // Nom et ID des types
    @Published var pokemonWeight: Int = 0
    @Published var pokemonHeight: Int = 0
    private let api = PokemonAPI()

    func fetchPokemon(by name: Int) {
        Task {
            do {
                let pokemon = try await api.pokemonService.fetchPokemon(name)
                
                DispatchQueue.main.async {
                    self.pokemonName = pokemon.name ?? "Unknown"
                    self.pokemonImageURL = pokemon.sprites?.frontDefault ?? ""
                    self.pokemonWeight = pokemon.weight ?? 0
                    self.pokemonHeight = pokemon.height ?? 0
                    // Récupère les noms et IDs des types
                                        self.pokemonTypes = pokemon.types?.compactMap { typeInfo in
                                            if let name = typeInfo.type?.name, let url = typeInfo.type?.url {
                                                return (name, self.extractID(from: url))
                                            }
                                            return nil
                                        } ?? []                }
            } catch {
                DispatchQueue.main.async {
                    self.pokemonName = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
    
    // Fonction pour extraire l'ID depuis l'URL
        private func extractID(from url: String) -> Int {
            let components = url.split(separator: "/").compactMap { Int($0) }
            return components.last ?? 0
        }
}
