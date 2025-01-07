//
//  Pokemon.swift
//  CLMVDex
//
//  Created by Luka DA COSTA on 06/01/2025.
//

import Foundation

struct FavoritePokemon: Codable {
    let id: Int
    let name: String
    let type: String 
}

extension String {
    func typeIdFromURL() -> Int? {
        // L'URL devrait ressembler à : https://pokeapi.co/api/v2/type/1/
        let components = self.split(separator: "/")
        guard let idString = components.last, let id = Int(idString) else {
            return nil
        }
        return id
    }
}

extension String {
    func pokemonIdFromURL() -> Int? {
        // L'URL devrait ressembler à : https://pokeapi.co/api/v2/pokemon/1/
        let components = self.split(separator: "/")
        guard let idString = components.last, let id = Int(idString) else {
            return nil
        }
        return id
    }
}

