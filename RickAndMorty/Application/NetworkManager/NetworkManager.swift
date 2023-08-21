//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 21.08.2023.
//

import Foundation

class NetworkManager {

    let decoder = JSONDecoder()

    func fetchCharacterData(completion: @escaping (_ characterData: CharacterModel) -> Void) {

        let urlString = "https://rickandmortyapi.com/api/character"
        guard let url = URL(string: urlString) else { return }

        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Something is wrong \(error)")
            }

            guard let data = data else { return }
            
            do {
                let character = try self.decoder.decode(CharacterModel.self, from: data)
                completion(character)
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
