//
//  EvolutionCard.swift
//  CLMVDex
//
//  Created by ShugoTenchi on 06/01/2025.
//

import SwiftUI

struct SearchBar: View {
    @State private var searchText: String = "" // Texte de recherche initialement vide
    let onSearch: (String) -> Void // Fonction appelée à chaque modification du texte

    var body: some View {
        HStack {
            TextField("Recherche", text: $searchText)
                .font(Font.custom("Jost", size: 20))
                .padding(.leading, 10)
                .onChange(of: searchText) { newValue in
                    onSearch(newValue)
                }
        }
        .frame(height: 43)
        .padding(.horizontal, 15)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color(EnumColor.background.rawValue))
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [Color(EnumColor.strokes2.rawValue), Color(EnumColor.strokes1.rawValue)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                ) 
        )
    }
}
