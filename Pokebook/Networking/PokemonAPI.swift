//
//  PokemonAPI.swift
//  Pokebook
//
//  Created by MD Sahil AK on 21/12/25.
//

import Foundation

enum PokemonAPI {
    static let baseURLPath: String = "https://pokeapi.co/api/v2/pokemon"
    static func imageURLPath(for id: Int) -> String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png"
    }
    
    case list
    case detail(id: Int)
    
    var path: String {
        switch self {
        case .list:
            return "\(Self.baseURLPath)/pokemon"
            
        case .detail(id: let id):
            return "\(Self.baseURLPath)/pokemon/\(id)"
        }
    }
}
