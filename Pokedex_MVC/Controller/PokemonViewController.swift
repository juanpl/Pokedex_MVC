//
//  PokemonViewController.swift
//  Pokedex_MVC
//
//  Created by Juan Pablo Lasprilla Correa on 25/09/24.
//

import UIKit

class PokemonViewController: UIViewController, PokemonImageProviderDelegate {

    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonHPLabel: UILabel!
    @IBOutlet weak var pokemonAttackLabel: UILabel!
    @IBOutlet weak var pokemonDefenseLabel: UILabel!
    @IBOutlet weak var pokemonSPATKLabel: UILabel!
    @IBOutlet weak var pokemonSPDefLabel: UILabel!
    @IBOutlet weak var pokemonSpeedLabel: UILabel!
    @IBOutlet weak var elementMov1Image: UIImageView!
    @IBOutlet weak var elementMov2Image: UIImageView!
    @IBOutlet weak var elementMov3Image: UIImageView!
    @IBOutlet weak var elementMov4Image: UIImageView!
    @IBOutlet weak var mov1NameLabel: UILabel!
    @IBOutlet weak var mov2NameLabel: UILabel!
    @IBOutlet weak var mov3NameLabel: UILabel!
    @IBOutlet weak var mov4NameLabel: UILabel!
    
    var pokemonInfoManager = PokemonInfoManager()
    var pokemonImageManager = PokemonImageManager()
    
    var pokemonId: Int?

    override func viewDidLoad() {
        
        pokemonInfoManager.delegate = self
        pokemonImageManager.delegate = self
        
        pokemonInfoManager.fetchPokemonInfo(id: pokemonId!)
        
        super.viewDidLoad()
    }
    
    func didReceiveImage(_ data: Data, pokemon: PokemonOnListModel) {
        DispatchQueue.main.async {
            self.pokemonImage.image = UIImage(data: data)
        }
    }
    
    func didFailToLoadImage(error: Error) {
        print(error)
    }
    
    
}

//MARK: - PokemonInfoManagerDelegate

extension PokemonViewController: PokemonInfoManagerDelegate {
    
    func didUpdatePokemonInfo(pokemonInf: PokemonModel) {
        DispatchQueue.main.async {
            self.pokemonNameLabel.text = pokemonInf.name
            self.pokemonHPLabel.text = String(pokemonInf.hp)
            self.pokemonAttackLabel.text = String(pokemonInf.attack)
            self.pokemonDefenseLabel.text = String(pokemonInf.defense)
            self.pokemonSPATKLabel.text = String(pokemonInf.specialAttack)
            self.pokemonSPDefLabel.text = String(pokemonInf.specialDefense)
            self.pokemonSpeedLabel.text = String(pokemonInf.speed)
            self.mov1NameLabel.text = pokemonInf.mov1Name
            self.mov2NameLabel.text = pokemonInf.mov2Name
            self.mov3NameLabel.text = pokemonInf.mov3Name
            self.mov4NameLabel.text = pokemonInf.mov4Name
            
            let pokemon = PokemonOnListModel(id: pokemonInf.id, name: pokemonInf.name)
            
            self.pokemonImageManager.fetchImage(from: pokemonInf.sprite, pokemon: pokemon)
            
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
