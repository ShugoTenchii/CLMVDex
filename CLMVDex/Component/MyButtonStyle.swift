//
//  MyButton.swift
//  CLMVDex
//
//  Created by ShugoTenchi on 25/12/2024.
//

import SwiftUI

struct MyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(30)
            .background(
                Circle()
                    .fill(Color(EnumColor.background.rawValue))
                    .shadow(color: Color(EnumColor.shadow1.rawValue), radius: 18, x: 9, y: 9)
                    .shadow(color: Color(EnumColor.shadow2.rawValue), radius: 18, x: -9, y: -9)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}


