//
//  PokeImageCarousel.swift
//  Pokebook
//
//  Created by MD Sahil AK on 23/12/25.
//

import SwiftUI

struct PokeImageCarousel: View {
    let pokemon: PokemonInformation
    
    @State private var currentImageIndex: Int? = nil
    
    var body: some View {
        VStack {
            indicator
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    imageCard(url: pokemon.imageURL)
                        .id(0)
                    
                    imageCard(url: pokemon.altImageURL)
                        .id(1)
                }
                .scrollTargetLayout()
            }
            .scrollPosition(id: $currentImageIndex)
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.paging)
        }
    }
    
    /// A single image card for the image carousel
    private func imageCard(url: URL?) -> some View {
        PokemonImageView(url: url)
            .frame(maxHeight: 350)
            .padding()
            .cardBackground()
            .padding(7)
            .containerRelativeFrame(.horizontal)
            .scrollTransition(.animated, axis: .horizontal) { content, phase in
                content
                    .opacity(phase.isIdentity ? 1.0 : 0.7)
                    .scaleEffect(phase.isIdentity ? 1.0 : 0.7)
            }
    }
    
    /// Interactive Indicator for the image carousel
    private var indicator: some View {
        HStack {
            ForEach(0..<2, id: \.self) { val in
                let current = currentImageIndex ?? 0
                
                Button(action: {
                    withAnimation {
                        currentImageIndex = val
                    }
                }, label: {
                    Image(systemName: "circle.fill")
                        .font(.system(size: 8))
                        .foregroundStyle(current == val ? Color(.accent) : Color(uiColor: .lightGray))
                })
            }
        }
        .padding(.bottom, 7)
    }
}

#Preview {
    PokeImageCarousel(pokemon: .mock())
}
