//
//  ThemeToggle.swift
//  CLMVDex
//
//  Created by ShugoTenchi on 05/01/2025.
//

import SwiftUI

struct ThemeToggle: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        ZStack {
            // Background du toggle
            RoundedRectangle(cornerRadius: 17)
                .fill(Color(EnumColor.background.rawValue))
                .frame(width: 56, height: 29)
                .shadow(color: Color(EnumColor.shadow1.rawValue), radius: 10, x: 5, y: 5)
                .shadow(color: Color(EnumColor.shadow2.rawValue), radius: 10, x: -5, y: -5)

            // Contenu du toggle
            HStack {
                Image(EnumAssets.moon.path)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)

                Spacer()

                Image(EnumAssets.sun.path)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
            }
            .padding(8)

            // Bouton glissant
            Circle()
                .fill(Color(EnumColor.background.rawValue))
                .frame(width: 19, height: 19)
                .offset(x: colorScheme == .dark ? 10 : -10)
                .shadow(color: Color(EnumColor.shadow1.rawValue), radius: 10, x: 5, y: 5)
                .shadow(color: Color(EnumColor.shadow2.rawValue), radius: 10, x: -5, y: -5)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onEnded { _ in
                            withAnimation(.spring()) {
                                themeManager.isDarkMode.toggle()
                            }
                        }
                )
        }
        .padding()
    }
}

