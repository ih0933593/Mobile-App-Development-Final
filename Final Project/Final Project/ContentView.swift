//
//  ContentView.swift
//  Final Project
//
//  Created by HILL, ISAAC on 4/30/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PokemonViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
//            Image(viewModel.pokemon.sprites.front_default)
//                .imageScale(.large)
//                .foregroundStyle(.tint)
            Text(viewModel.name)
//            Text(viewModel.id)
//            Text(viewModel.height)
        }
        .padding()
        .onAppear {
            viewModel.fetchPokemon()
        }
    }
}

#Preview {
    ContentView()
}
