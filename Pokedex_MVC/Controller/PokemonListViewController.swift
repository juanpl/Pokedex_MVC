//
//  PokemonListViewController.swift
//  Pokedex_MVC
//
//  Created by Juan Pablo Lasprilla Correa on 11/09/24.
//

import UIKit

class PokemonListViewController: UIViewController {

    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    
    var pokemonListManager = PokemonListManager()
    var pokemonImageManager = PokemonImageManager()
    
    var PokemonList: [PokemonOnListModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonListManager.delegate = self
        pokemonImageManager.delegate = self
        
        pokemonListManager.fetchPokemonList(limit: 3, offset: 0)
        print(PokemonList.count)
    }
    
}

//MARK: - PokemonListManagerDelegate

extension PokemonListViewController: PokemonListManagerDelegate {
    
    func didUpdatePokemonList(_ pokemonListManager: PokemonListManager, pokemonList: [PokemonOnListModel]) {
        DispatchQueue.main.async {
            self.pokemonName.text = pokemonList[0].name
            self.pokemonImageManager.fetchImage(from: pokemonList[0].sprite)
            
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}


//MARK: - PokemonImageProviderDelegate

extension PokemonListViewController: PokemonImageProviderDelegate {
    func didReceiveImage(_ data: Data) {
        DispatchQueue.main.async {
            let image = UIImage(data: data)!
            self.pokemonImage.image = image
        }
    }
    
    func didFailToLoadImage(error: Error) {
        print(error)
    }
}


