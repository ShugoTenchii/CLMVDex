//
//  CLMVDexApp.swift
//  CLMVDex
//
//  Created by ShugoTenchi on 25/12/2024.
//

import SwiftUI

@main
struct CLMVDexApp: App {
    @StateObject private var themeManager = ThemeManager()
    private var pokemonFacade = Facade.shared
    @State private var path: [EnumPage] = []
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {
                            ScrollView {
                                VStack {
                                    Header(pokemonFacade: pokemonFacade, path: $path) // Passe la pile à Header
                                        .environmentObject(themeManager)
                                        .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
                                    
                                    MainMenu(path: $path, pokemonFacade: pokemonFacade) // Passe la pile à MainMenu
                                        .environmentObject(themeManager)
                                        .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
                                }
                                .padding(.horizontal, 12)
                                .padding(.top, 20)
                            }                            .background(Color(EnumColor.background.rawValue))
                                .navigationDestination(for: EnumPage.self) { page in
                                switch page {
                                case .mainMenu:
                                    MainMenu(path: $path, pokemonFacade: pokemonFacade)
                                case .mesFavoris:
                                    MesFavoris(path: $path, pokemonFacade: pokemonFacade)
                                }
                            }
                        }
        }
    }
}

