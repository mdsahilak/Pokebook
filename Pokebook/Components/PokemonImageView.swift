//
//  PokemonImageView.swift
//  Pokedex
//
//  Created by Sahil Ak on 02/07/2024.
//

import SwiftUI
import NukeUI

/// Asynchrously loaded image view for displaying pokemon artwork
struct PokemonImageView: View {
    var url: URL? = nil
    var contentMode: ContentMode = .fit
    
    var body: some View {
        LazyImage(url: url) { state in
            if state.isLoading {
                CircularLoaderView()
            } else {
                if let image = state.image {
                    image
                        .resizable()
                        .aspectRatio(1, contentMode: contentMode)
                } else {
                    Image(systemName: "exclamationmark.circle")
                        .aspectRatio(1, contentMode: .fit)
                        .font(.system(size: 33))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
    }
}

#Preview {
    PokemonImageView()
}
