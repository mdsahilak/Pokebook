//
//  PokemonLink.swift
//  Pokedex
//
//  Created by Sahil Ak on 02/07/2024.
//

import Foundation

/// The A pokemon object representing very basic information about a pokemon.
struct PokemonLink: Codable, Hashable, Identifiable {
    var id: Int { Int((url as NSString).lastPathComponent) ?? 0 }
    
    var name: String
    
    /// The url to access detailed information about the pokemon
    var url: String
    
    var imageURL: URL? { URL(string: PokemonAPI.imageURLPath(for: id)) }
}


extension PokemonLink {
    /// Mock object for testing in previews & unit tests
    static func mock() -> Self {
        Self(name: "squirtle", url: "\(PokemonAPI.baseURLPath)/7/")
    }
}
