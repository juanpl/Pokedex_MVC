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
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        //1.Create a URL
        
        if let url = URL(string: urlString){
            
            //2.Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3.Give the session task
            let task = session.dataTask(with: url){ (data, reponse, error) in
                if error != nil{
                    print(error!)
                    return
                }
                
                if let safeData = data{
                    self.parseJSON(pokemonDataAPI: safeData)
                }
            }
            
            //4.Start task
            task.resume()
            
        }
        
    }
    
    func parseJSON(pokemonDataAPI: Data){
        
    }
    
}
