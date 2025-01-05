//
//  EnumAssets.swift
//  CLMVDex
//
//  Created by ShugoTenchi on 05/01/2025.
//

enum EnumAssets {
    private static let assetsFileSVG = "./Assets/SVG/"
    private static let assetsFileImage = "./Assets/Image/"
    
    case moon
    case sun
    case add
    case pokeball

    var path: String {
        switch self {
        case .moon:
            return EnumAssets.assetsFileImage + "moon.png"
        case .sun:
            return EnumAssets.assetsFileImage + "sun.png"
        case .add:
            return EnumAssets.assetsFileSVG + "add.svg"
        case .pokeball:
            return EnumAssets.assetsFileSVG + "pokeball.svg"
        }
    }
}

