//
//  CharactersListViewModel.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 23.01.2024.
//

import Foundation

class CharactersListViewModel: CharactersListViewModelProtocol {

    // MARK: - Properties

    var characterData: Box<[CharactersCellViewModelProtocol]?> = Box(nil)

    // MARK: - Dependencies

    private var networkService = DataFetcherService()

    // MARK: - Methods

    func fetchCharacterData() {
        networkService.fetchUserData { [weak self] characterInfo in
            guard let self, let characterInfo else { return }
            
            self.characterData.value = characterInfo.results.map({ CharactersCellViewModel(dataSource: $0 )})
        }
    }
}
