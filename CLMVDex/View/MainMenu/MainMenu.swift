//
//  ContentView.swift
//  CLMVDex
//
//  Created by ShugoTenchi on 25/12/2024.
//

import SwiftUI
import PokemonAPI

struct MainMenu: View {
    @Binding var path: [EnumPage]
    @State private var currentOffset = 0
    @State private var isLoading = false
    @State private var allPokemonList: [PKMPokemon] = [] // Liste complète de PKMPokemon
    @State private var filteredPokemonList: [PKMPokemon] = [] // Liste filtrée de PKMPokemon
    @State private var selectedPokemon: PKMPokemon? // Pokémon sélectionné pour la grande carte
    @State private var searchText: String = ""
    var pokemonFacade: Facade

    var body: some View {
        VStack {
            // Affichage du Pokémon sélectionné dans la grande carte
            if let pokemon = selectedPokemon {
                FirstCard(pokemon: pokemon)
            } else {
                Text("Chargement en cours...")
                    .font(.headline)
            }

            Spacer()

            // Bouton d'ajout aux favoris
            HStack {
                Spacer()
                if let pokemon = selectedPokemon {
                    Button(action: {
                        Task {
                            try? await pokemonFacade.addPokemonToFavorites(byId: pokemon.id ?? 0)

                            print("Ajouté aux favoris : \(pokemon.name ?? "Inconnu")")
                            var pokemon = try? await pokemonFacade.getPokemonById(byId: pokemon.id ?? 0)
                            print(pokemon?.species?.name)
                        }
                    }) {
                        Image(EnumAssets.add.rawValue)
                            .resizable()
                            .foregroundStyle(Color(EnumColor.noBackground.rawValue))
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }
                    .buttonStyle(MyButtonStyle())
                }
            }
            .padding(.top, 15)

            Spacer()

            //EvolutionCard()

            //Spacer()

            // Recherche et carrousel des Pokémon
            VStack {
                SearchBar { query in
                    searchText = query
                    Task {
                        await updateFilteredList(query: query)
                    }
                }

                CarouselView(pokemonList: filteredPokemonList, onSelect: { pokemon in
                    Task {
                        await selectPokemon(pokemon: pokemon)
                    }
                }, onLoadMore: {
                    Task {
                        await loadMorePokemon() // Charge la prochaine page
                    }
                })
                .padding(.top, 15)
            }
            .padding(.top, 15)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.vertical, 20)
        .background(Color("Background"))
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            Task {
                await loadInitialPokemon()
            }
        }
    }

    private func FirstCard(pokemon: PKMPokemon) -> some View {
        MyCard(frameWidth: 0, frameHeight: 320) {
            VStack {
                HStack {
                    Text("\(pokemon.id ?? 0) - \(pokemon.name ?? "Inconnu")")
                        .font(Font.custom("Jost", size: 20))
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 30)

                Spacer()
                AsyncImage(url: URL(string: pokemon.sprites?.frontDefault ?? ""))
                    .scaledToFit()
                    .frame(width: 200, height: 200)

                Spacer()

                HStack {
                    Spacer()
                    let type1 = String(pokemon.types?.first?.type?.url?.typeIdFromURL() ?? 1)
                    let type2 = String(pokemon.types?.dropFirst().first?.type?.url?.typeIdFromURL() ?? 1)
                    TypesView(Type1: type1, Type2: type2)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 30)
            }
        }
    }

    private func loadInitialPokemon() async {
        guard allPokemonList.isEmpty else { return } // Ne recharge pas si la liste existe déjà

        do {
            print("Chargement initial des Pokémon...")
            let pokemonResources = try await pokemonFacade.getPaginatedPokemon(offset: 0, limit: 20)
            await MainActor.run {
                allPokemonList = pokemonResources
                filteredPokemonList = pokemonResources
                currentOffset = pokemonResources.count // Met à jour avec le nombre chargé
                print("Initial offset : \(currentOffset)")

                if let firstPokemon = pokemonResources.first {
                    selectedPokemon = firstPokemon
                }
            }
        } catch {
            print("Erreur lors du chargement initial : \(error)")
        }
    }


    private func loadMorePokemon() async {
        guard !isLoading else {
            print("Chargement déjà en cours")
            return
        }
        isLoading = true
        defer { isLoading = false }

        do {
            print("Appel API avec offset : \(currentOffset), limite : 20")
            let newPokemon = try await pokemonFacade.getPaginatedPokemon(offset: currentOffset, limit: 20)

            await MainActor.run {
                if !newPokemon.isEmpty {
                    let uniquePokemon = newPokemon.filter { newPokemon in
                        !allPokemonList.contains { $0.id == newPokemon.id }
                    }
                    allPokemonList.append(contentsOf: uniquePokemon)
                    filteredPokemonList = allPokemonList

                    // Mise à jour de l'offset uniquement si des Pokémon uniques sont ajoutés
                    currentOffset += uniquePokemon.count
                    print("Nouveaux Pokémon chargés : \(uniquePokemon.count), Offset mis à jour : \(currentOffset)")
                } else {
                    print("Aucun nouveau Pokémon à ajouter")
                }
            }
        } catch {
            print("Erreur lors du chargement des Pokémon supplémentaires : \(error)")
        }
    }



    private func selectPokemon(pokemon: PKMPokemon) async {
        await MainActor.run {
            selectedPokemon = pokemon
        }
    }

    private func updateFilteredList(query: String) async {
        guard !query.isEmpty else {
            // Si la recherche est vide, réinitialise à la liste complète
            await MainActor.run {
                filteredPokemonList = allPokemonList
            }
            return
        }

        do {
            isLoading = true

            let results = try await pokemonFacade.searchPokemon(by: query, existingPokemon: allPokemonList)
            await MainActor.run {
                filteredPokemonList = results
            }
        } catch {
            print("Erreur lors de la recherche de Pokémon : \(error)")
        }
            isLoading = false

    }


    private func fetchPokemonDetails(from resources: [PKMNamedAPIResource<PKMPokemon>]) async throws -> [PKMPokemon] {
        return try await withThrowingTaskGroup(of: PKMPokemon?.self) { group in
            for resource in resources {
                if let id = resource.url?.pokemonIdFromURL() {
                    group.addTask {
                        return try? await pokemonFacade.getFavoriteDetails(byId: id)
                    }
                }
            }

            var results: [PKMPokemon] = []
            for try await pokemon in group {
                if let pokemon = pokemon {
                    results.append(pokemon)
                }
            }
            return results
        }
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

extension PKMPokemon: @retroactive Equatable {
    public static func == (lhs: PKMPokemon, rhs: PKMPokemon) -> Bool {
        return lhs.id == rhs.id
    }
}
