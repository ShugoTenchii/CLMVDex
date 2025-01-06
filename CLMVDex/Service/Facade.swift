//
//  Facade.swift
//  CLMVDex
//
//  Created by ShugoTenchi on 06/01/2025.
//
import PokemonAPI



class Facade {
    private let service: PokemonServiceProtocol
        
    init(service: PokemonServiceProtocol = PokemonService()) {
            self.service = service
        }
    
    static let shared = Facade()
    
    private let pokemonService = PokemonService()
    
    private var cachedPokemonList: [Pokemon]?
    
    /// Récupère la liste des noms des Pokémon.
      func getPokemonList() async -> Result<[String], Error> {
          do {
              let pokemonList = try await service.fetchPokemonList()
              let names = pokemonList.compactMap { $0.name }
              return .success(names)
          } catch {
              return .failure(error)
          }
      }
    
    /// Récupère un Pokémon spécifique par son nom.
        func getPokemon(by name: String) async -> Result<PKMPokemon, Error> {
            do {
                let pokemon = try await service.fetchPokemon(by: name)
                return .success(pokemon)
            } catch {
                return .failure(error)
            }
        }

        /// Recherche des Pokémon par un nom partiel.
        func searchPokemon(by query: String) async -> Result<[String], Error> {
            do {
                let matchingPokemon = try await service.searchPokemon(by: query)
                let names = matchingPokemon.compactMap { $0.name }
                return .success(names)
            } catch {
                return .failure(error)
            }
        }

        /// Sauvegarde un Pokémon récupéré par son nom.
        func savePokemon(name: String) async -> Result<Pokemon, Error> {
            do {
                let pokemon = try await service.savePokemon(name: name)
                return .success(pokemon)
            } catch {
                return .failure(error)
            }
        }
}
