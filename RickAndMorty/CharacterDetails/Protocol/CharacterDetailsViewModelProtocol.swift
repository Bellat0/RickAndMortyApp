//
//  CharacterDetailsViewModelProtocol.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 23.01.2024.
//

import Foundation

protocol CharacterDetailsViewModelProtocol {
    var characterCellViewModel: CharactersCellViewModelProtocol { get }
   
    var locationData: Box<LocationCellViewModelProtocol?> { get }
    var episodeData: Box<[EpisodesCellViewModelProtocol]?> { get }

    func fetchLocationData()
    func fetchEpisodeData()
}
