//
//  EvolutionCard.swift
//  CLMVDex
//
//  Created by ShugoTenchi on 06/01/2025.
//

import SwiftUI

struct EvolutionCard: View {
    let asMega: Bool
    
    init(asMega: Bool = false) { // Fournit une valeur par défaut
        self.asMega = asMega
    }
    
    var body: some View {
        VStack{
            HStack{
                MylittleCard(frameHeight: 114){
                    Image(EnumAssets.pokeball.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 200)
                }
                MylittleCard(frameHeight: 114){
                    Image(EnumAssets.pokeball.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 200)
                }
            }
            if(asMega){
                MylittleCard(frameHeight: 114){
                    Image(EnumAssets.pokeball.rawValue)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 200)
                }
            }
        }
        .frame(height: asMega ? 238 : 114)
        .padding(.vertical, 25)
    }
}
