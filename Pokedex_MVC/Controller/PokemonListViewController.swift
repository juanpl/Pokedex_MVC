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
    @IBOutlet weak var searchTextField: UITextField!
    
    var pokemonListManager = PokemonListManager()
    var pokemonImageManager = PokemonImageManager()
    var pokemonSearchManager = PokemonSearchManager()
    
    var selectedItemId: Int?
    
    var pokemonListVar: [PokemonOnListModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        pokemonListManager.delegate = self
        pokemonImageManager.delegate = self
        pokemonSearchManager.delegate = self
        tableView.dataSource = self
        searchTextField.delegate = self
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        configureTextFieldWithClearButton(textField: searchTextField, frame: CGRect(x: 50, y: 200, width: 250, height: 40))
        
        
        pokemonListManager.fetchPokemonList(limit: 1025, offset: 0)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPokemonView" {
            let destinationVC = segue.destination as! PokemonViewController
            destinationVC.pokemonId = selectedItemId
        }
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
    
    func didReceiveImage(_ data: Data, pokemon: PokemonOnListModel) {
        guard let index = pokemonListVar.firstIndex(where: { $0.id == pokemon.id }) else { return }
        pokemon.data = data
        let indexPath = IndexPath(row: index, section: 0)
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
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
        let item = pokemonListVar[indexPath.row]
        cell.delegate = self
        cell.setup(item)
        return cell
    }
}


//MARK: - PokemonCardDelegate
extension PokemonListViewController: PokemonCardDelegate{
    func fetchImageCard(pokemon: PokemonOnListModel) {
        pokemonImageManager.fetchImage(from: pokemon.sprite, pokemon: pokemon)
    }
}

// MARK: - UITableViewDelegate

extension PokemonListViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItemId = pokemonListVar[indexPath.row].id
        self.performSegue(withIdentifier: K.segueToPokemonView, sender: self)
    }
    
}



//MARK: - UITextFieldDelegate
extension PokemonListViewController: UITextFieldDelegate {
    

    @IBAction func serachButtonPressed(_ sender: Any) {
        searchTextField.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let pokemonNameSearch = searchTextField.text{
            pokemonSearchManager.fetchPokemonSearch(pokemonName: pokemonNameSearch)
        }
    }
    
    
    
    func configureTextFieldWithClearButton(textField: UITextField, frame: CGRect) {
        
            // Crear el botón "x"
            let clearButton = UIButton(type: .custom)
            clearButton.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
            clearButton.frame = CGRect(x: 0, y: 0, width: 10, height: 10)

            // Añadir acción al botón "x"
            clearButton.addTarget(self, action: #selector(clearTextField), for: .touchUpInside)

            // Asignar el botón al rightView del textField
            textField.rightView = clearButton
            textField.rightViewMode = .always
        }

        // Función para limpiar el contenido del textField
        @objc func clearTextField() {
            searchTextField.text = ""
            pokemonListManager.fetchPokemonList(limit: 1025, offset: 0)

        }


}

//MARK: - PokemonSearchManagerDelegate
extension PokemonListViewController: PokemonSearchManagerDelegate {
    
    func didUpdatePokemonSearch(pokemonList: [PokemonOnListModel]) {
        DispatchQueue.main.async {
            self.pokemonListVar = pokemonList
            self.tableView.reloadData()
            
        }
    }
    
    func searchPokemonFailwithError(error: Error) {
        // Manejo del error
        print("Error: \(error.localizedDescription)")
    }
    
    
}

 


