//
//  ClickableSVGView.swift
//  CLMVDex
//
//  Created by ShugoTenchi on 05/01/2025.
//

import SwiftUI

struct ClickableSVG: View {
    let svgName: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(svgName ?? EnumAssets.pokeball.path)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()
        }
        .buttonStyle(PlainButtonStyle())
    }
}
