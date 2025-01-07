//
//  ClickableSVGView.swift
//  CLMVDex
//
//  Created by ShugoTenchi on 05/01/2025.
//

import SwiftUI

struct ClickableSVG: View {
    let svgName: String
    let height: CGFloat
    let weight: CGFloat
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(svgName)
                .resizable()
                .foregroundStyle(Color(EnumColor.noBackground.rawValue))
                .scaledToFit()
                .frame(width: height, height: weight)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
