//
//  PokemonService.swift
//  CLMVDex
//
//  Created by ShugoTenchi on 06/01/2025.
//

class PokemonService {
    func loadPokemonList() -> [Pokemon] {
        return [
            Pokemon(id: 1, name: "Bulbasaur", type: "Grass"),
            Pokemon(id: 2, name: "Ivysaur", type: "Grass"),
            Pokemon(id: 3, name: "Charmander", type: "Fire"),
            Pokemon(id: 4, name: "Pikachu", type: "Electric")
        ]
    }
    
    func findPokemon(byName name: String?, orID id: Int?, in list: [Pokemon]) -> Pokemon? {
            return list.first { pokemon in
                if let id = id {
                    return pokemon.id == id
                }
                if let name = name {
                    return pokemon.name.lowercased() == name.lowercased()
                }
                return false
            }
        }

        func searchPokemon(byName name: String?, orID id: Int?, in list: [Pokemon]) -> [Pokemon] {
            return list.filter { pokemon in
                var matches = true
                if let id = id {
                    matches = matches && pokemon.id == id
                }
                if let name = name {
                    matches = matches && pokemon.name.lowercased().contains(name.lowercased())
                }
                return matches
            }
        }
}
