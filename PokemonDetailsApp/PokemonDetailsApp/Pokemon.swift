//
//  Pokemon.swift
//  PokemonDetailsApp
//
//  Created by Yavuz Güner on 17.10.2022.
//

import Foundation

//ViewController'ımızdaki tableview yapısı için çekeceğimiz olan Api'dan alacağımız verilerin modeli.
struct Pokemon: Codable {
    let count: Int
    let next: String
    let results: [Result]
}


struct Result: Codable {
    let name: String
    let url: String
}




//DetailViewController'da kullanacağımız Title Label, CollectionView ve Tableview yapısı için çekeceğimiz veriler buradadır. Çok katmanlı bir veri vardı fakat halihazırda kullanacağımız kısmı çektim.
// MARK: - PokemonDetail
struct PokemonDetail: Codable {
    let id: Int
    let name: String
    let species: Species
    let sprites: Sprites
    let stats: [Stat]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case species, sprites, stats
    }
}


// MARK: - Species
struct Species: Codable {
    let name: String
    let url: String
}


// MARK: - Sprites
class Sprites: Codable {
    let backDefault: String
    let backShiny: String
    let frontDefault: String
    let frontShiny: String
    
    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
    
    init(backDefault: String,  backShiny: String,  frontDefault: String,  frontShiny: String) {
        self.backDefault = backDefault
        self.backShiny = backShiny
        self.frontDefault = frontDefault
        self.frontShiny = frontShiny
    }
}


// MARK: - Stat
struct Stat: Codable {
    let baseStat, effort: Int
    let stat: Species
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}





