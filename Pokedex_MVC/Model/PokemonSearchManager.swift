//
//  PokemonSearchManager.swift
//  Pokedex_MVC
//
//  Created by Juan Pablo Lasprilla Correa on 23/09/24.
//

import Foundation

protocol PokemonSearchManagerDelegate {
    func didUpdatePokemonSearch(pokemonList: [PokemonOnListModel])
    func searchPokemonFailwithError(error: Error)
}

struct PokemonSearchManager {
    
    let pokeAPI_URL = K.PokeAPI.URL
    
    var delegate: PokemonSearchManagerDelegate?
    
    func fetchPokemonSearch(pokemonName: String?){
        if let safePokemonName = pokemonName {
            let urlString = "\(pokeAPI_URL)/pokemon/\(safePokemonName.lowercased())"
            performRequest(with: urlString)
        }
        
    }
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            
            let session  = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url){(data, response, error) in
                if error != nil{
                    delegate?.searchPokemonFailwithError(error: error!)
                }
                
                if let safeData = data{
                    if let pokemonSearch = parseJSON(pokemonDataAPI: safeData){
                        delegate?.didUpdatePokemonSearch(pokemonList: pokemonSearch)
                    }
                }
                
                
            }
            

            task.resume()
        }
    }
    
    func parseJSON(pokemonDataAPI: Data) -> [PokemonOnListModel]? {
        
        let decoder = JSONDecoder()
        
        do{
            let decodeData = try decoder.decode(PokemonOnListModel.self, from: pokemonDataAPI)
            var pokemonList:[PokemonOnListModel] = []
            
            let pokemonSearch = PokemonOnListModel(id: decodeData.id, name: decodeData.name)
            pokemonList.append(pokemonSearch)
            
            return pokemonList
            
        } catch{
            delegate?.searchPokemonFailwithError(error: error)
            return nil
        }
        
    }
}
