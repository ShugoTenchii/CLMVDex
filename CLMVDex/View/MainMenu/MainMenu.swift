//
//  ContentView.swift
//  CLMVDex
//
//  Created by ShugoTenchi on 25/12/2024.
//

import SwiftUI

struct MainMenu: View {
    var body: some View {
        VStack {
            MyCard(frameWidth: 0, frameHeight: 320){
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, 15)
        .background(Color("Background"))
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    MainMenu()
}
