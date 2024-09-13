//
//  PokemonOnListModel.swift
//  Pokedex_MVC
//
//  Created by Juan Pablo Lasprilla Correa on 13/09/24.
//

import Foundation

struct PokemonOnListModel{
    let id: Int
    let name: String
    var sprite: String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
    }
}
