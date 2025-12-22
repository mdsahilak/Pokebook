//
//  PokemonList.swift
//  Pokedex
//
//  Created by Sahil Ak on 05/07/2024.
//

import Foundation

/// The data model to represent the JSON sent by the API for a paginated pokemon list fetch
struct PokemonList: Codable {
    /// Total count of all pokemons available
    var count: Int
    
    /// The url for the next page of pokemons
    var next: String?
    
    /// The url for the previous page of pokemons
    var previous: String?
    
    /// The current list of fetched pokemons.
    var results: [PokemonLink]
}
