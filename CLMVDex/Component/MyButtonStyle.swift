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
            .padding(.vertical, 12)
            .padding(.horizontal, 12)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(EnumColor.background.rawValue))
                    .shadow(color: Color(EnumColor.shadow2.rawValue), radius: 9, x: -9, y: -9)
                    .shadow(color: Color(EnumColor.shadow1.rawValue), radius: 9, x: 9, y: 9)
                    .frame(width: 55, height: 55, alignment: .center)

            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}


