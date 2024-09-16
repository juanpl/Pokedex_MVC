//
//  PokemonListViewController.swift
//  Pokedex_MVC
//
//  Created by Juan Pablo Lasprilla Correa on 11/09/24.
//

import UIKit

class PokemonListViewController: UIViewController, PokemonListManagerDelegate {

    
    var pokemonListManager = PokemonListManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonListManager.delegate = self
        pokemonListManager.fetchPokemonList(limit: 3, offset: 0)
    }
    
    func didUpdatePokemonList(_ pokemonListManager: PokemonListManager, pokemonList: [PokemonOnListModel]) {
        print(pokemonList[0].name)
    }
    
    
    func didFailWithError(error: Error) {
        print(error)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
