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
        ZStack {
            VStack(spacing: 20) {
                Text("Welcome")
                Text(viewModel.usableData[0][0])
            }
            .padding()
        }
        .onAppear {
            viewModel.fetchPokemon()
        }
    }
}

#Preview {
    ContentView()
}
