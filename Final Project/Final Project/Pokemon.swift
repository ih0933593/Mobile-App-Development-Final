//
//  APIResponse.swift
//  Final Project
//
//  Created by HILL, ISAAC on 4/30/25.
//

import Foundation
import SwiftUI

// Structs for API json data
struct PokemonResponse: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Result]
}

struct Result: Codable {
    let name: String?
    let url: String?
}

struct Pokemon: Codable {
    let name: String?
    let height: Int?
    let weight: Int?
    let sprites: [Sprite]
}

struct Sprite: Codable {
    let front_default: String?
}



class PokemonViewModel: ObservableObject {
    @Published var Newurl: String?
    //@Published var respone: String?
    
    func fetchPokemon() {
//        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/35/") else {
//            print("Invalid URL")
//            return
//        }
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?limit=5") else {
            print("Invalid URL")
            return
        }
        print("Hello World")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(PokemonResponse.self, from: data)
                    
                    print("Ahhhhhhhhh")
                    
                    for response in decodedResponse.results {
                        DispatchQueue.main.async {
                            self.Newurl = decodedResponse.results[0].url
                        }
                    }
                    
                    
                    print("Ehhhhhhhh")
                } catch {
                    print ("Decoding error: \(error)")
                }
            } else if let error = error {
                print("HTTP Request Failed: \(error)")
            }
        }.resume()
        
        print("Goodbye World")
    }
}
