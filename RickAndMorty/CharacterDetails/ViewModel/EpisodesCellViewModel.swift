//
//  EpisodesCellViewModel.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 23.01.2024.
//

import Foundation

class EpisodesCellViewModel: EpisodesCellViewModelProtocol {
    var name: String
    var episode: String
    var airDate: String
    var characters: [String]
    
    init(dataSource: EpisodesResult) {
        name = dataSource.name
        episode = dataSource.episode
        airDate = dataSource.airDate
        characters = dataSource.characters
    }
}
