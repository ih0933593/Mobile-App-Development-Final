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
}



class PokemonViewModel: ObservableObject {
    @Published var Newurl: String? = ""
    @Published var name: String?
    @Published var height: Int?
    @Published var weight: Int?
    
    func fetchPokemon() {
//        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/35/") else {
//            print("Invalid URL")
//            return
//        }
        guard var APIurl = URL(string: "https://pokeapi.co/api/v2/pokemon/?limit=5") else {
            print("Invalid URL")
            return
        }
        print("Hello World")
        
        URLSession.shared.dataTask(with: APIurl) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse1 = try JSONDecoder().decode(PokemonResponse.self, from: data)
                    
                    print("Ahhhhhhhhh")
                    
                    var i = 0
                    for response in decodedResponse1.results {
                        DispatchQueue.main.async {
                            self.Newurl = decodedResponse1.results[i].url
                        }
                        print(self.Newurl)
                        APIurl = URL(string: self.Newurl!)!
                        print(APIurl)
                        
                        URLSession.shared.dataTask(with: APIurl) { data, response, error in
                            if let data = data {
                                do {
                                    let decodedResponse2 = try JSONDecoder().decode(Pokemon.self, from: data)
                                    
                                    DispatchQueue.main.async {
                                        self.name = decodedResponse2.name
                                        self.height = decodedResponse2.height
                                        self.weight = decodedResponse2.weight
                                    }
                                } catch {
                                    print ("Decoding error: \(error)")
                                }
                            } else if let error = error {
                                print("HTTP Request Failed: \(error)")
                            }
                            
                        }.resume()
                        i += 1
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
