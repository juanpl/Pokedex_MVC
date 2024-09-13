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
        performRequest(urlString: urlString, offset: offset)
    }
    
    func performRequest(urlString: String, offset: Int){
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
                    self.parseJSON(pokemonDataAPI: safeData, offset: offset)
                }
            }
            
            //4.Start task
            task.resume()
            
        }
        
    }
    
    func parseJSON(pokemonDataAPI: Data, offset: Int){
        let decoder = JSONDecoder()
        do{
            let decodeData = try decoder.decode(PokemonListData.self, from: pokemonDataAPI)
            print(decodeData.results[0].name)
            var pokemonList: [PokemonOnListModel] = []
            
            for (index,pokemon) in decodeData.results.enumerated() {
                let id = index + 1 + offset //You must add one because the list of Pokemon starts at number 1 and also adds the offset
                let name = pokemon.name
                
                let pokemonOnList = PokemonOnListModel(id: id, name: name)
                pokemonList.append(pokemonOnList)
            }
            
        } catch{
            print(error)
        }
        
    }
    
}
