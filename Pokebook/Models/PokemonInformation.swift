//
//  PokemonInformation.swift
//  Pokedex
//
//  Created by Sahil Ak on 03/07/2024.
//

import SwiftUI

/// A pokemon object representing detailed information about a pokemon
struct PokemonInformation: Codable, Identifiable {
    var height: Int
    
    var id: Int
    var name: String
    
    /// All stats related to the pokemon
    var statInfos: [StatInfo]
    
    var weight: Int
    
    var imageURL: URL? { URL(string: PokemonAPI.imageURLPath(for: id)) }
    var altImageURL: URL? { (URL(string: PokemonAPI.altImageURLPath(for: id))) }
    
    enum CodingKeys: String, CodingKey {
        case height
        case id
        case name
        case statInfos = "stats"
        case weight
    }
    
    /// Object representing the value of a particular stat
    struct StatInfo: Codable, Identifiable {
        var id: String { statLink.name }
        
        var baseStat: Double
        var statLink: StatLink
        
        enum CodingKeys: String, CodingKey {
            case baseStat
            case statLink = "stat"
        }
        
        /// Object representing the type of stat
        struct StatLink: Codable {
            var name: String
            var url: String
        }
    }
    
}

extension PokemonInformation {
    static func mock() -> Self {
        .init(
            height: 10,
            id: 7,
            name: "squirtle",
            statInfos: [],
            weight: 69
        )
    }
}
