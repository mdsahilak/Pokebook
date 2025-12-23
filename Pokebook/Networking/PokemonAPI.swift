//
//  PokemonAPI.swift
//  Pokebook
//
//  Created by MD Sahil AK on 21/12/25.
//

import Foundation

enum PokemonAPI {
    case pokelist
    case pokedetail(id: Int)
    
    static let baseURLPath: String = "https://pokeapi.co/api/v2"
    
    static func imageURLPath(for id: Int) -> String {
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png"
    }
    
    static func altImageURLPath(for id: Int) -> String {
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/\(id).png"
    }
    
    var path: String {
        switch self {
        case .pokelist:
            return "\(Self.baseURLPath)/pokemon"
            
        case .pokedetail(id: let id):
            return "\(Self.baseURLPath)/pokemon/\(id)"
        }
    }
    
    func url() throws -> URL {
        guard let url = URL(string: path) else { throw APIError.invalidURL }
        return url
    }
}
