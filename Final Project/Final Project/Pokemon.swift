//
//  APIResponse.swift
//  Final Project
//
//  Created by HILL, ISAAC on 4/30/25.
//

import Foundation

// Structs for API json data
struct PokemonResponse: Codable, Hashable {
//    let pokemon: Pokemon
//    let id : Int
//    let name : String
//    let height : Int
//    let species: Species
//    let datasets: [Dataset]
//    let fields: [String]
    let results: [Pokemon]
}

struct Pokemon: Codable, Hashable, Identifiable {
//    let url: String
//    let name: String
    
    let count: Int
    let next: String
    let previous: String
    let id: Int
//    let results: [Result]
}

struct Result: Codable {
    let index: [Index]
}

struct Index: Codable {
    let url: String
}

//struct Dataset: Codable {
//    let fields: [Field]
//}
//
//struct Field: Codable {
//    let name : String
//    let height: Int
//}
//
//struct Species: Codable {
//    
//    let name: String
////    let height: Int
////    let sprites: Sprites
////    let name: String
//}

//struct Sprites: Codable {
//    let front_default: String
//}


class PokemonViewModel: ObservableObject {
//    @Published var id: Int = 0
    @Published var name: String = ""
    @Published var height: Int = 0
    
    // Could maybe send in a parameter for the id instead of getting a whole bunch all at once
    func fetchPokemon() {
//        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/35/") else {
//            print("Invalid URL")
//            return
//        }
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/") else {
            print("Invalid URL")
            return
        }
        print("Hello World")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(PokemonResponse.self, from: data)
                    
                    print("Ahhhhhhhhh")
                    
                    DispatchQueue.main.async {
//                        self.id = decodedResponse.id
//                        self.name = decodedResponse.name
//                        self.height = decodedResponse.height
                    }
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
