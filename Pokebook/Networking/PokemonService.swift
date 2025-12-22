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

// MARK: Live Implementation
@Observable
final class LivePokemonService: PokemonService {
    let router: NetworkRouter = NetworkRouter()
    
    func fetchPokemonList(url: URL?) async throws -> PokemonList {
        guard let url = URL(string: PokemonAPI.list.path) else { throw NetworkError.invalidURL }
        
        return try await router.data(from: url, decoding: PokemonList.self)
    }
    
    func fetchPokemonInformation(for id: Int) async throws -> PokemonInformation {
        guard let url = URL(string: PokemonAPI.detail(id: id).path) else { throw NetworkError.invalidURL }
        
        return try await router.data(from: url, decoding: PokemonInformation.self)
    }
}

// MARK: Mock Implementation
@Observable
final class MockPokemonService: PokemonService {
    func fetchPokemonList(url: URL?) async throws -> PokemonList {
        return PokemonList(count: 1, next: nil, previous: nil, results: [.mock])
    }
    
    func fetchPokemonInformation(for id: Int) async throws -> PokemonInformation {
        return PokemonInformation(height: 50, id: 7, name: "squirtle", statInfos: [], weight: 50)
    }
}
