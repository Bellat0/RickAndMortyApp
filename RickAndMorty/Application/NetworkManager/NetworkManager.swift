//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 21.08.2023.
//

import Foundation

class NetworkManager {

    let urlStringCharacters = "https://rickandmortyapi.com/api/character"
    let urlStringLocation = "https://rickandmortyapi.com/api/location"
    let urlStringEpisodes = "https://rickandmortyapi.com/api/episode"

    let decoder = JSONDecoder()

    func fetchCharacterData(completion: @escaping (_ characterData: CharacterModel) -> Void) {

        guard let url = URL(string: urlStringCharacters) else { return }

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

    func fetchLocationData(completion: @escaping (_ locationData: LocationModel) -> Void) {

        guard let url = URL(string: urlStringLocation) else { return }

        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Something is wrong \(error)")
            }

            guard let data = data else { return }

            do {
                let location = try self.decoder.decode(LocationModel.self, from: data)
                completion(location)
            } catch let error {
                print(error)
            }
        }.resume()
    }

    func fetchEpisodeData(completion: @escaping (_ episodeData: EpisodeModel) -> Void) {

        guard let url = URL(string: urlStringEpisodes) else { return }

        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Something is wrong \(error)")
            }

            guard let data = data else { return }

            do {
                let episode = try self.decoder.decode(EpisodeModel.self, from: data)
                completion(episode)
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
