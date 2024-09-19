//
//  PokemonCard.swift
//  Pokedex_MVC
//
//  Created by Juan Pablo Lasprilla Correa on 19/09/24.
//

import UIKit

class PokemonCard: UITableViewCell {

    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
