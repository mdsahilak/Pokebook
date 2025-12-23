//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Sahil Ak on 03/07/2024.
//

import SwiftUI

/// View to display detailed information about a pokemon
struct PokemonDetailView: View {
    @State var vm: PokemonDetailViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack {
                    if let pokemon = vm.pokemonInfo {
                        PokeImageCarousel(pokemon: pokemon)
                            .accessibilityHidden(true)
                        
                        heightAndWeightBar(for: pokemon)
                        
                        statsView(for: pokemon)
                    } else {
                        CircularLoaderView()
                            .padding(.top, 190)
                    }
                }
                .padding()
                .task {
                    await vm.loadPokemonInformation()
                }
            }
            .scrollIndicators(.hidden)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("\(vm.pokemonLink.name.capitalized)")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    dismissButton
                }
            }
        }
    }
    
    /// Height and weight display bar
    @ViewBuilder
    private func heightAndWeightBar(for pokemon: PokemonInformation) -> some View {
        Divider()
        HStack {
            Text("Height: \(pokemon.height)")
            Divider()
            Text("Weight: \(pokemon.weight)")
        }
        Divider()
    }
    
    /// View to display the statics using progress bars
    @ViewBuilder
    private func statsView(for pokemon: PokemonInformation) -> some View {
        ForEach(pokemon.statInfos) { statInfo in
            ProgressView(value: statInfo.baseStat, total: Constants.statsMaxValue) {
                HStack {
                    Text(statInfo.statLink.name.capitalized)
                    Spacer()
                    Text("\(statInfo.baseStat, specifier: "%.0f")")
                }
            }
            .padding(7)
        }
    }
    
    /// Dismiss button for the sheet's navigation bar
    private var dismissButton: some View {
        Button {
            dismiss()
        } label: {
            Label("Dismiss", systemImage: "chevron.down")
        }
    }
}

#Preview {
    PokemonDetailView(vm: .init(pokemonLink: .mock(), service: MockPokemonService()))
}
