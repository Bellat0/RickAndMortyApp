//
//  DataFetcherService.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 22.09.2023.
//

import Foundation

class DataFetcherService {

    //MARK: - URL

    let urlCharacter = "https://rickandmortyapi.com/api/character"
    let urlLocation = "https://rickandmortyapi.com/api/location"
    let urlEpisode = "https://rickandmortyapi.com/api/episode"

    //MARK: - Внешние зависимости

    var networkDataFetcher: DataFetcher

    //MARK: - Init

    init(dataFetcher: NetworkDataFetcher = NetworkDataFetcher()) {
        self.networkDataFetcher = dataFetcher
    }

    //MARK: - FetchData methods

    func fetchUserData(completion: @escaping (_ characterInfo: CharacterModel?) -> Void) {
        networkDataFetcher.fetchGenericJSONData(urlString: urlCharacter, response: completion)
    }

    func fetchLocationData(completion: @escaping (_ locationInfo: LocationModel?) -> Void) {
        networkDataFetcher.fetchGenericJSONData(urlString: urlLocation, response: completion)
    }

    func fetchEpisodeData(completion: @escaping (_ episodeInfo: EpisodeModel?) -> Void) {
        networkDataFetcher.fetchGenericJSONData(urlString: urlEpisode, response: completion)
    }
}
