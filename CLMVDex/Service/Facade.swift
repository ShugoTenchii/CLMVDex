//
//  Facade.swift
//  CLMVDex
//
//  Created by ShugoTenchi on 06/01/2025.
//

class Facade {
    static let shared = Facade()
    
    private let pokemonService = PokemonService()
    
    private var cachedPokemonList: [Pokemon]?
    
    func getPokemonList() -> [Pokemon] {
        if cachedPokemonList == nil {
            cachedPokemonList = pokemonService.loadPokemonList()
        }
        return cachedPokemonList!
    }
    
    func getPokemon(name: String? = nil, id: Int? = nil) -> Pokemon? {
        let pokemonList = getPokemonList()
        return pokemonService.findPokemon(byName: name, orID: id, in: pokemonList)
    }
    
    func getPokemonName(name: String? = nil, id: Int? = nil) -> String {
        return ""
    }
    
    func getPokemonImage(name: String? = nil, id: Int? = nil) -> String {
        return ""
    }
    
    func getPokemonType(name: String? = nil, id: Int? = nil) -> [String] {
        return ["Type1", "Type2"]
    }
    
    func searchPokemon(name: String? = nil, id: Int? = nil) -> [Pokemon] {
        let pokemonList = getPokemonList()
        return pokemonService.searchPokemon(byName: name, orID: id, in: pokemonList)
    }
}
