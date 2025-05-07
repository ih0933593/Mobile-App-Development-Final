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
    @Published var name: String = ""
    @Published var height: Int = 0
    @Published var weight: Int = 0
    @Published var usableData: [[String]] = [[]]
    
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
                    let decodedResponse = try JSONDecoder().decode(PokemonResponse.self, from: data)
                    
                    print("Ahhhhhhhhh")
                    
                    var i = 0
                    for _ in decodedResponse.results {
                        DispatchQueue.main.async {
                            self.Newurl = decodedResponse.results[i].url
                        }
                        print(self.Newurl)
                        APIurl = URL(string: self.Newurl!)!
                        print(APIurl)
                        
                        URLSession.shared.dataTask(with: APIurl) { data, response, error in
                            if let data = data {
                                do {
                                    let decodedResponse = try JSONDecoder().decode(Pokemon.self, from: data)
                                    
                                    DispatchQueue.main.async {
                                        self.name = decodedResponse.name!
                                        self.height = decodedResponse.height!
                                        self.weight = decodedResponse.weight!
                                        
                                        
                                        let index = self.usableData.count - 1
                                        
                                        self.usableData[index].append(self.name)
                                        self.usableData[index].append("\(self.height)")
                                        self.usableData[index].append("\(self.weight)")
                                        
                                        self.usableData.append([])
                                        print(self.name)
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
        
        
    }
}
