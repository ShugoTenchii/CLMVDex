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
                HStack{
                    Text("448 - Lucario")
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 30)
                Spacer()
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Spacer()
                HStack{
                    Spacer()
                    TypesView(Type1: "2", Type2: "9")
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 30)
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
