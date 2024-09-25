//
//  PokemonOnListModel.swift
//  Pokedex_MVC
//
//  Created by Juan Pablo Lasprilla Correa on 13/09/24.
//

import Foundation

final class PokemonOnListModel: Codable{
    let id: Int
    let name: String
    var sprite: String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
    }
    var data: Data?
    
    init(id: Int, name: String, data: Data? = nil) {
        self.id = id
        self.name = name
        self.data = data
    }
}
