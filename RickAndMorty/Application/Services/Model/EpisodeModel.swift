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
    let episode: String
    let created: String
    let characters: [String]
}
