//
//  CharacterDetailsViewModel.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 23.01.2024.
//

import Foundation

class CharacterDetailsViewModel: CharacterDetailsViewModelProtocol {

    // MARK: - Properties

    var locationData: Box<LocationCellViewModelProtocol?> = Box(nil)
    var episodeData: Box<[EpisodesCellViewModelProtocol]?> = Box(nil)

    var characterCellViewModel: CharactersCellViewModelProtocol

    // MARK: - Dependencies

    private var networkService = DataFetcherService()

    // MARK: - Init

    init(characterCellViewModel: CharactersCellViewModelProtocol) {
        self.characterCellViewModel = characterCellViewModel
    }

    // MARK: - Methods

    func fetchLocationData() {
        networkService.fetchLocationData { [weak self] locationInfo in
            guard let self = self else { return }

            let location = locationInfo?.results.first { result in
                result.residents.contains { string in
                    string.hasSuffix("\(self.characterCellViewModel.id)")
                }
            }

            if let location {
                locationData.value = LocationCellViewModel(dataSource: location)
            }
        }
    }

    func fetchEpisodeData() {
        networkService.fetchEpisodeData { [weak self] episodeInfo in
            guard let self = self else { return }
            
            let episodes = episodeInfo?.results.filter({ result in
                result.characters.contains { string in
                    string.hasSuffix("\(self.characterCellViewModel.id)")
                }
            })

            if let episodes {
                episodeData.value = episodes.compactMap({ EpisodesCellViewModel(dataSource: $0 )})
            }
        }
    }
}
