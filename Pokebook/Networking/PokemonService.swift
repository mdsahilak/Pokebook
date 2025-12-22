//
//  PokemonService.swift
//  Pokebook
//
//  Created by MD Sahil AK on 22/12/25.
//

import Foundation

protocol PokemonService {
    func fetchPokemonList(url: URL?) async throws -> PokemonList
    
    func fetchPokemonInformation(for id: Int) async throws -> PokemonInformation
}

// MARK: - Live Implementation -
final class LivePokemonService: PokemonService {
    let router: APIRouter = APIRouter()
    
    func fetchPokemonList(url: URL?) async throws -> PokemonList {
        guard let url else { throw APIError.invalidURL }
        
        return try await router.data(from: url, decoding: PokemonList.self)
    }
    
    func fetchPokemonInformation(for id: Int) async throws -> PokemonInformation {
        guard let url = URL(string: PokemonAPI.pokedetail(id: id).path) else { throw APIError.invalidURL }
        
        return try await router.data(from: url, decoding: PokemonInformation.self)
    }
}

// MARK: - Mock Implementation -
final class MockPokemonService: PokemonService {
    func fetchPokemonList(url: URL?) async throws -> PokemonList {
        return PokemonList(count: 1, next: nil, previous: nil, results: [.mock])
    }
    
    func fetchPokemonInformation(for id: Int) async throws -> PokemonInformation {
        return PokemonInformation(height: 50, id: 7, name: "squirtle", statInfos: [], weight: 50)
    }
}
