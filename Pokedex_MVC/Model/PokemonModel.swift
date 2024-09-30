//
//  PokemonModel.swift
//  Pokedex_MVC
//
//  Created by Juan Pablo Lasprilla Correa on 26/09/24.
//

import Foundation

class PokemonModel {
    
    let id: Int
    let name: String
    var sprite: String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
    }
    let hp: Int
    let attack: Int
    let defense: Int
    let specialAttack: Int
    let specialDefense: Int
    let speed: Int
    let mov1Name: String
    let mov2Name: String
    let mov3Name: String
    let mov4Name: String
    let mov1Sprite: String?
    let mov2Sprite: String?
    let mov3Sprite: String?
    let mov4Sprite: String?
    
    init(id: Int, name: String, hp: Int, attack: Int, defense: Int, specialAttack: Int, specialDefense: Int, speed: Int, mov1Name: String, mov2Name: String, mov3Name: String, mov4Name: String, mov1Sprite: String? = nil, mov2Sprite: String? = nil, mov3Sprite: String? = nil, mov4Sprite: String? = nil) {
        self.id = id
        self.name = name
        self.hp = hp
        self.attack = attack
        self.defense = defense
        self.specialAttack = specialAttack
        self.specialDefense = specialDefense
        self.speed = speed
        self.mov1Name = mov1Name
        self.mov2Name = mov2Name
        self.mov3Name = mov3Name
        self.mov4Name = mov4Name
        self.mov1Sprite = mov1Sprite
        self.mov2Sprite = mov2Sprite
        self.mov3Sprite = mov3Sprite
        self.mov4Sprite = mov4Sprite
    }
    
}
