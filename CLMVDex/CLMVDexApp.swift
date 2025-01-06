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
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                
                NavigationView {
                    VStack {
                        Header(pokemonFacade: pokemonFacade)
                            .environmentObject(themeManager)
                            .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
                        MainMenu(pokemonFacade: pokemonFacade)
                            .environmentObject(themeManager)
                            .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
                    }
                    .padding(.horizontal, 12)
                }
            }
        }
    }
}

