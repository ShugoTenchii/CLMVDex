//
//  ContentView.swift
//  CLMVDex
//
//  Created by ShugoTenchi on 06/01/2025.
//

import SwiftUI

struct ContentView: View {
    var pokemonFacade : Facade
    @State private var path: [EnumPage] = [] // Gestion de la pile de navigation

    var body: some View {
        NavigationStack(path: $path) {
            MainMenu(path: $path, pokemonFacade: pokemonFacade) // Passe la navigation à MainMenu
        }
    }
}
