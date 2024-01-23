//
//  EpisodesCellViewModelProtocol.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 23.01.2024.
//

import Foundation

protocol EpisodesCellViewModelProtocol {
    var name: String { get }
    var airDate: String { get }
    var episode: String { get }
    var characters: [String] { get }
}
