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
    var body: some Scene {
        WindowGroup {
                   ZStack {
                       Color("Background")
                           .edgesIgnoringSafeArea(.all)

                       VStack {
                           Header()
                               .environmentObject(themeManager)
                               .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
                           MainMenu()
                               .environmentObject(themeManager)
                               .preferredColorScheme(themeManager.isDarkMode ? .dark : .light)
                       }
                       .padding(.horizontal, 12)
                   }
               }
    }
}

