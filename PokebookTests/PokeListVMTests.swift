//
//  PokeListVMTests.swift
//  PokebookTests
//
//  Created by MD Sahil AK on 23/12/25.
//

import Testing
@testable import Pokebook

@MainActor
struct PokeListVMTests {
    let viewModel = PokeListViewModel(service: LivePokemonService())
//    let viewModel = PokeListViewModel(service: MockPokemonService())
    
    @Test func initialPokemonIsNil() async throws {
        #expect(viewModel.pokemons == nil, "Pokemons should be nil.")
    }
    
    @Test func testInitialSelectedPokemonIsNil() {
        #expect(viewModel.selectedPokemon == nil, "Selected pokemon should be nil.")
    }
    
    @Test func testInitialPaginationLoaderStateIsFalse() {
        #expect(viewModel.showPaginationLoader == false, "Pagination loader should not be shown initially.")
    }
    
    @Test func testInitialSearchStateIsNotSearching() {
        #expect(viewModel.isSearching == false, "IsSearching should be false.")
    }
    
    @Test func testInitialSearchTextIsEmpty() {
        #expect(viewModel.searchText.isEmpty, "SearchText should be an empty string.")
    }
    
    @Test func testSearchingForPokemon() async throws {
        await viewModel.loadPokemons()
        
        let searchName = "charizard"
        viewModel.searchText = searchName
        
        let searchResults = try #require(viewModel.searchedPokemons, "Searched pokemons should not be nil")
        
        #expect(searchResults.count == 1)
        
        let result = try #require(searchResults.first)
        
        #expect(result.name == searchName, "Search should filter out the correct pokemon.")
    }
    
    @Test func testFetchingPokemonsFromAPI() async throws {
        await viewModel.loadPokemons()
        
        let pokemonsCount = try #require(viewModel.pokemons, "Pokemons should not be nil").count
        let expectedCount = Constants.paginationLimit
        
        #expect(pokemonsCount == expectedCount, "API call should fetch the correct no. of pokemons.")
    }
    
    @Test func testPaginationOfPokemonFetchesFromAPI() async throws {
        await viewModel.loadPokemons()
        await viewModel.loadNextPageofPokemons()
        
        let pokemonsCount = try #require(viewModel.pokemons).count
        let expectedCount = Constants.paginationLimit * 2
        
        #expect(pokemonsCount == expectedCount, "Pagination call should fetch the next page of pokemons.")
    }

}
