//
//  PokemonListManager.swift
//  Pokedex_MVC
//
//  Created by Juan Pablo Lasprilla Correa on 12/09/24.
//

import Foundation

protocol  PokemonListManagerDelegate {
    func didUpdatePokemonList(_ pokemonListManager: PokemonListManager,pokemonList: [PokemonOnListModel])
    func didFailWithError(error: Error)
}

struct PokemonListManager{
    let pokeAPI_URL = K.PokeAPI.URL
    
    var delegate: PokemonListManagerDelegate?
    
    func fetchPokemonList(limit: Int, offset: Int){
        let urlString = "\(pokeAPI_URL)/pokemon/?limit=\(limit)&offset=\(offset)"
        performRequest(with: urlString, offset: offset)
    }
    
    
    func performRequest(with urlString: String, offset: Int){
        //1.Create a URL
        if let url = URL(string: urlString){
            
            //2.Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3.Give the session task
            let task = session.dataTask(with: url){ (data, reponse, error) in
                if error != nil{
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data{
                    if let pokemonList = self.parseJSON(safeData, offset: offset){
                        delegate?.didUpdatePokemonList(self, pokemonList: pokemonList)
                    }
                }
            }
            
            //4.Start task
            task.resume()
            
        }
        
    }
    
    func parseJSON(_ pokemonDataAPI: Data, offset: Int) -> [PokemonOnListModel]? {
        let decoder = JSONDecoder()
        
        do{
            let decodeData = try decoder.decode(PokemonListData.self, from: pokemonDataAPI)
            var pokemonList: [PokemonOnListModel] = []
            
            for (index,pokemon) in decodeData.results.enumerated() {
                let id = index + 1 + offset //You must add one because the list of Pokemon starts at number 1 and also adds the offset
                let name = pokemon.name
                
                let pokemonOnList = PokemonOnListModel(id: id, name: name)
                pokemonList.append(pokemonOnList)
            }
            
            return pokemonList
            
        } catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
}
