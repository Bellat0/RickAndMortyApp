//
//  EpisodeModel.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 21.08.2023.
//

import Foundation

struct EpisodeModel: Codable {
    let results: [EpisodesResult]
}

struct EpisodesResult: Codable {
    let id: Int
    let name: String
    let airDate: String
    let characters: [String]
    let episode: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case characters
        case episode
    }
}
