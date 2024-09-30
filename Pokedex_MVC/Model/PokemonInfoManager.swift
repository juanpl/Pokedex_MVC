//
//  PokemonInfoManager.swift
//  Pokedex_MVC
//
//  Created by Juan Pablo Lasprilla Correa on 26/09/24.
//

import Foundation

protocol PokemonInfoManagerDelegate {
    func didUpdatePokemonInfo(pokemonInf: PokemonModel)
    func didFailWithError(error: Error)
}

struct PokemonInfoManager {
    
    let pokeAPI_URL = K.PokeAPI.URL
    
    var delegate: PokemonInfoManagerDelegate?
    
    func fetchPokemonInfo(id: Int){
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(id)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        //Create URL
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url){ (data, response, error) in
                if error != nil{
                    delegate?.didFailWithError(error: error!)
                }
                
                if let safeData = data {
                    if let pokemonInf = self.parseJSON(safeData) {
                        delegate?.didUpdatePokemonInfo(pokemonInf: pokemonInf)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ pokemonDataAPI: Data) -> PokemonModel? {
        let decoder = JSONDecoder()
        
        do{
            let decodeData = try decoder.decode(PokemonData.self, from: pokemonDataAPI)
            let pokemon = PokemonModel(
                id: decodeData.id,
                name: decodeData.name,
                hp: decodeData.stats[0].base_stat,
                attack: decodeData.stats[1].base_stat,
                defense: decodeData.stats[2].base_stat,
                specialAttack: decodeData.stats[3].base_stat,
                specialDefense: decodeData.stats[4].base_stat,
                speed: decodeData.stats[5].base_stat,
                mov1Name: decodeData.moves[0].move.name,
                mov2Name: decodeData.moves[1].move.name,
                mov3Name: decodeData.moves[2].move.name,
                mov4Name: decodeData.moves[3].move.name
            )
            
            return pokemon
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}
