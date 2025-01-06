//
//  PokemonService.swift
//  CLMVDex
//
//  Created by ShugoTenchi on 06/01/2025.
//

class PokemonService {
    func loadPokemonList() -> [Pokemon] {
        return [
            Pokemon(id: 1, name: "Lucario", image: EnumAssets.pokeball.rawValue, type1: "2", type2: "9", asMega: false),
            Pokemon(id: 2, name: "Bulbasaur", image: "", type1: "12", type2: "", asMega: false),
            Pokemon(id: 3, name: "Charmander", image: "", type1: "3", type2: "1", asMega: false),
            Pokemon(id: 4, name: "Pikachu", image: "", type1: "4", type2: "", asMega: false)
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
