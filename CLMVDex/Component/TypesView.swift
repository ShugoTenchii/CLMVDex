//
//  TypesView.swift
//  CLMVDex
//
//  Created by ShugoTenchi on 06/01/2025.
//

import SwiftUI

struct TypesView: View {
    let Type1: String
    let Type2: String
    
    var body: some View {
        HStack{
            if(!Type2.isEmpty && Type2 != Type1){
                Image(Type2)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 20)
            }
            Spacer()
            Image(Type1)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 20)
        }
        .frame(width: 128, height: 20)
    }
}
