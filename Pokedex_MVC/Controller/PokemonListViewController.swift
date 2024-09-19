//
//  PokemonListViewController.swift
//  Pokedex_MVC
//
//  Created by Juan Pablo Lasprilla Correa on 11/09/24.
//

import UIKit

class PokemonListViewController: UIViewController{
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var pokemonListManager = PokemonListManager()
    var pokemonImageManager = PokemonImageManager()
    
    var pokemonListVar: [PokemonOnListModel] = []
    var arrayTest = ["a", "a", "a"]

    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.delegate = self
        pokemonListManager.delegate = self
        pokemonImageManager.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        
        
        pokemonListManager.fetchPokemonList(limit: 3, offset: 0)
        
    }
    
}

//MARK: - PokemonListManagerDelegate

extension PokemonListViewController: PokemonListManagerDelegate {
    
    func didUpdatePokemonList(_ pokemonListManager: PokemonListManager, pokemonList: [PokemonOnListModel]) {
        DispatchQueue.main.async {
            self.pokemonListVar = pokemonList
            self.tableView.reloadData()
            
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
            //self.pokemonImage.image = image
        }
    }
    
    func didFailToLoadImage(error: Error) {
        print(error)
    }
}

//MARK: - UITableViewDataSource
extension PokemonListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonListVar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! PokemonCard
        cell.pokemonNameLabel.text = pokemonListVar[indexPath.row].name
        return cell
    }
}


/*
 
 Use this delegate when you want to perform an action when clicking on a list item.
 
// MARK: - UITableViewDelegate

extension PokemonListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
 */

