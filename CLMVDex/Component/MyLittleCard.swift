//
//  Card.swift
//  CLMVDex
//
//  Created by ShugoTenchi on 25/12/2024.
//

import SwiftUI

struct MylittleCard<Content: View>: View {
    let content: Content
    var frameWidth: CGFloat?
    var frameHeight: CGFloat?

    init(frameWidth: CGFloat? = nil, frameHeight: CGFloat? = nil, @ViewBuilder content: () -> Content) {
        self.frameWidth = frameWidth
        self.frameHeight = frameHeight
        self.content = content()
    }

    var body: some View {
        VStack () {
            content
        }
        .padding(.vertical, 25)
        .frame(maxWidth: .infinity, minHeight: frameHeight, maxHeight: frameHeight, alignment: .center)
        .cornerRadius(30)
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color(EnumColor.background.rawValue))
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [Color(EnumColor.strokes2.rawValue), Color(EnumColor.strokes1.rawValue)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing)
                    , lineWidth: 1)
                .shadow(color: Color(EnumColor.shadow2.rawValue), radius: 9, x: -9, y: -9)
                .shadow(color: Color(EnumColor.shadow1.rawValue), radius: 9, x: 9, y: 9)
            
        )
    }
}
