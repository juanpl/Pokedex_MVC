//
//  PokemonListData.swift
//  Pokedex_MVC
//
//  Created by Juan Pablo Lasprilla Correa on 12/09/24.
//

import Foundation

struct PokemonListData: Codable {
    let next: String?
    let previous: String?
    let results: [PokemonInTheList]
}

struct PokemonInTheList: Codable{
    let name: String
    let url: String
}
