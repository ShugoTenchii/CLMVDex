//
//  DataLoaderView.swift
//  CLMVDex
//
//  Created by Luka DA COSTA on 06/01/2025.
//

import SwiftUI
import PokemonAPI

struct DataLoaderView: View {
    @State private var isLoading = false // Indicateur de chargement
    @State private var progress: Double = 0.0 // Progression du chargement
    @State private var cacheCompleted = false // Indicateur de succès
    var pokemonFacade: Facade // La façade pour gérer les données Pokémon

    var body: some View {
        VStack(spacing: 20) {
            Text("Bienvenue dans CLMVDex")
                .font(Font.custom("Jost", size: 24))
                .padding()

            if isLoading {
                ProgressView("Chargement des données Pokémon...", value: progress, total: 1.0)
                    .progressViewStyle(LinearProgressViewStyle())
                    .padding()
            } else if cacheCompleted {
                Text("Les données Pokémon ont été mises en cache avec succès.")
                    .foregroundColor(.green)
                    .padding()
                Button("Continuer") {
                    // Naviguer vers l'application principale
                    // Exemple : Modifier un @Binding var currentView pour passer à la vue suivante
                }
                .buttonStyle(MyButtonStyle())
            } else {
                Button("Précharger les Pokémon") {
                    Task {
                        await loadAndCachePokemon()
                    }
                }
                .buttonStyle(MyButtonStyle())
            }
        }
        .padding()
    }

    private func loadAndCachePokemon() async {
        isLoading = true
        progress = 0.0
        cacheCompleted = false

        do {
            // Récupérer les métadonnées
            let pokemonResources = try await pokemonFacade.getAllPokemon()
            
            // Indiquer que le cache est terminé
            await MainActor.run {
                isLoading = false
                cacheCompleted = true
            }
        } catch {
            print("Erreur lors du chargement des Pokémon : \(error.localizedDescription)")
            await MainActor.run {
                isLoading = false
                cacheCompleted = false
            }
        }
    }
}
