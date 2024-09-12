//
//  PokemonListManager.swift
//  Pokedex_MVC
//
//  Created by Juan Pablo Lasprilla Correa on 12/09/24.
//

import Foundation

struct PokemonListManager{
    let pokeAPI_URL = K.PokeAPI.URL
    
    func fetchPokemonList(limit: Int, offset: Int){
        let urlString = "\(pokeAPI_URL)/pokemon/?limit=\(limit)&offset=\(offset)"
        print(urlString)
    }
    
}
