//
//  PokemonData.swift
//  Pokedex_MVC
//
//  Created by Juan Pablo Lasprilla Correa on 26/09/24.
//

import Foundation

struct PokemonData: Decodable {
    let name: String
    let id: Int
    let stats: [Stats]
    let moves: [Moves]
}

struct Stats: Decodable {
    let base_stat: Int
}

struct Moves: Decodable {
    let move: Move
}

struct Move: Decodable {
    let name: String
}
