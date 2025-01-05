//
//  Card.swift
//  CLMVDex
//
//  Created by ShugoTenchi on 25/12/2024.
//

import SwiftUI

struct MyCard<Content: View>: View {
    let content: Content
    var frameWidth: CGFloat?
    var frameHeight: CGFloat?

    init(frameWidth: CGFloat? = nil, frameHeight: CGFloat? = nil, @ViewBuilder content: () -> Content) {
        self.frameWidth = frameWidth
        self.frameHeight = frameHeight
        self.content = content()
    }

    var body: some View {
        VStack {
            content
                .frame(alignment: .center)
        }
        .padding(.horizontal, 0)
        .padding(.vertical, 30)
        .frame(maxWidth: (frameWidth != nil && frameWidth! <= 0 ? .infinity-20 : frameWidth!), maxHeight: frameHeight)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color(EnumColor.background.rawValue))
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [Color(EnumColor.strokes2.rawValue), Color(EnumColor.strokes1.rawValue)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing)
                    , lineWidth: 2)
                .shadow(color: Color(EnumColor.shadow1.rawValue), radius: 64, x: 32, y: 32)
                .shadow(color: Color(EnumColor.shadow2.rawValue), radius: 64, x: -32, y: -32)
            
        )
    }
}

