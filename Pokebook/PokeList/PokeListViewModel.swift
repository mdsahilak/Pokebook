//
//  PokeListViewModel.swift
//  Pokebook
//
//  Created by MD Sahil AK on 22/12/25.
//

import Foundation
import Combine

@MainActor
final class PokeListViewModel: ObservableObject {
    let service: PokemonService
    
    /// List of all the fetched pokemons
    @Published var pokemons: [PokemonLink]? = nil
    
    /// The pokemon that was selected to be shown in the detail screen.
    @Published var selectedPokemon: PokemonLink? = nil
    
    // Search Bar
    @Published var isSearching: Bool = false
    @Published var searchText: String = ""
    
    /// State to show / hide the loader while fetching the next page of pokemons
    @Published var showPaginationLoader: Bool = false
    
    /// The url  to fetch the next page of pokemons
    private var nextPagePath: String? = nil
    
    /// Filtered list of pokemons using the keywords from the search bar.
    public var searchedPokemons: [PokemonLink]? {
        guard let pokemons else { return nil }
        
        if searchText.isEmpty {
            return pokemons
        } else {
            let filteredPokemons = pokemons.filter { $0.name.contains(searchText.lowercased()) }
            return filteredPokemons
        }
    }
    
    init(service: PokemonService, pokemons: [PokemonLink]? = nil, selectedPokemon: PokemonLink? = nil, isSearching: Bool, searchText: String, showPaginationLoader: Bool, nextPagePath: String? = nil) {
        self.service = service
        self.pokemons = pokemons
        self.selectedPokemon = selectedPokemon
        self.isSearching = isSearching
        self.searchText = searchText
        self.showPaginationLoader = showPaginationLoader
        self.nextPagePath = nextPagePath
    }
    
}

// MARK: - API Call Handlers -
extension PokeListViewModel {
    /// Initial API fetch for Pokemons for the first page of pokemons
    func loadPokemons() async {
        do {
            let data = try await service.fetchPokemonList(url: URL(string: PokemonAPI.pokelist.path))
            
            pokemons = data.results
            nextPagePath = data.next
        } catch {
            pokemons = []
            print(error)
        }
    }
    
    /// Fetches the next page of upto 20 pokemons
    func loadNextPageofPokemons() async {
        do {
            guard let nextPage = nextPagePath else { return }
            
            showPaginationLoader = true
            
            let data = try await service.fetchPokemonList(url: URL(string: nextPage))
            
            pokemons?.append(contentsOf: data.results)
            nextPagePath = data.next
            
            showPaginationLoader = false
        } catch {
            print(error)
        }
    }
}
