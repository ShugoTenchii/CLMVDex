//
//  PokemonView.swift
//  CLMVDex
//
//  Created by Luka DA COSTA on 06/01/2025.
//

import SwiftUI

struct PokemonView: View {
    @StateObject private var viewModel = PokemonViewModel()

    var body: some View {
        VStack {
            // Image du Pokémon
            if let imageURL = URL(string: viewModel.pokemonImageURL), !viewModel.pokemonImageURL.isEmpty {
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                } placeholder: {
                    ProgressView()
                }
            } else {
                Text("No Image Available")
                    .foregroundColor(.gray)
            }

            // Nom du Pokémon
            Text(viewModel.pokemonName)
                .font(.largeTitle)
                .padding()

            // Types avec noms et IDs
            if !viewModel.pokemonTypes.isEmpty {
                VStack {
                    Text("Types:")
                        .font(.headline)
                    ForEach(viewModel.pokemonTypes, id: \.id) { type in
                        Text("\(type.name.capitalized) (ID: \(type.id))")
                            .font(.subheadline)
                    }
                }
                .padding()
            }

            // Poids et taille
            HStack {
                Text("Weight: \(viewModel.pokemonWeight) kg")
                Text("Height: \(viewModel.pokemonHeight) m")
            }
            .font(.subheadline)
            .padding()

            // Bouton pour récupérer un Pokémon
            Button("Fetch Pikachu") {
                viewModel.fetchPokemon(by: 1)
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
    }
}

#Preview {
    PokemonView()
}
