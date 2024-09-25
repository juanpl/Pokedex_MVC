//
//  PokemonImageManager.swift
//  Pokedex_MVC
//
//  Created by Juan Pablo Lasprilla Correa on 18/09/24.
//

import Foundation

protocol PokemonImageProviderDelegate: AnyObject {
    // Método que se llama cuando la imagen es descargada exitosamente
    func didReceiveImage(_ data: Data, pokemon: PokemonOnListModel)
    
    // Método que se llama si ocurre un error durante la descarga de la imagen
    func didFailToLoadImage(error: Error)
}

struct PokemonImageManager {
    
    // Definimos una propiedad weak para evitar ciclos de retención
    weak var delegate: PokemonImageProviderDelegate?

    // Método para descargar la imagen desde una URL
    func fetchImage(from urlString: String, pokemon: PokemonOnListModel) {
        // Verificar si la URL es válida
        guard let url = URL(string: urlString) else {
            print("URL inválida")
            return
        }
        
        // Descargar la imagen de manera asincrónica
        URLSession.shared.dataTask(with: url) {  (data, response, error) in
            // Manejar errores de red
            if let error = error {
                DispatchQueue.main.async {
                    delegate?.didFailToLoadImage(error: error)
                }
                return
            }
            
            // Verificar si se ha recibido data válida
            guard let data = data else {
                DispatchQueue.main.async {
                    delegate?.didFailToLoadImage(error: NSError(domain: "ImageError", code: -1, userInfo: nil))
                }
                return
            }
            
            // Notificar al delegate que la imagen fue recibida exitosamente
            DispatchQueue.main.async {
                delegate?.didReceiveImage(data, pokemon: pokemon)
            }
        }.resume()
    }
    
}
