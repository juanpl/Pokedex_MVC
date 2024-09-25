//
//  PokemonCard.swift
//  Pokedex_MVC
//
//  Created by Juan Pablo Lasprilla Correa on 19/09/24.
//

import UIKit

protocol PokemonCardDelegate{
    func fetchImageCard(pokemon: PokemonOnListModel)
}

class PokemonCard: UITableViewCell{

    @IBOutlet private weak var pokemonImageView: UIImageView!
    @IBOutlet private weak var pokemonNameLabel: UILabel!
    
    var delegate: PokemonCardDelegate?
    
    
    func setup(_ pokemon: PokemonOnListModel) {
        pokemonNameLabel.text = pokemon.name
        if let data = pokemon.data {
            pokemonImageView.image = UIImage(data: data)
        } else{
            delegate?.fetchImageCard(pokemon: pokemon)
        }
    }
    
}


