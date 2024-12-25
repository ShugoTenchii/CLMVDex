//
//  ContentView.swift
//  CLMVDex
//
//  Created by ShugoTenchi on 25/12/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            MyCard(frameWidth: 0, frameHeight: 320){
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Background"))
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ContentView()
}
