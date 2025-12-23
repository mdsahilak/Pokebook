//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Sahil Ak on 03/07/2024.
//

import Foundation
import Combine

@MainActor
@Observable
final class PokemonDetailViewModel {
    let pokemonLink: PokemonLink
    let service: PokemonService
    
    /// The detailed information related to the currently selected pokemon
    var pokemonInfo: PokemonInformation? = nil
    
    init(pokemonLink: PokemonLink, service: PokemonService) {
        self.pokemonLink = pokemonLink
        self.service = service
    }
    
}

// MARK: - API Call Handlers -
extension PokemonDetailViewModel {
    /// Fetch detailed information about the selected pokemon
    public func loadPokemonInformation() async {
        do {
            pokemonInfo = try await service.fetchPokemonInformation(for: pokemonLink.id)
        } catch {
            print(error)
        }
    }
}
