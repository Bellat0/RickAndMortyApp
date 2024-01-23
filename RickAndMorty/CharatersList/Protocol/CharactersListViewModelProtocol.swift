//
//  CharactersListViewModelProtocol.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 23.01.2024.
//

import Foundation

protocol CharactersListViewModelProtocol {
    var characterData: Box<[CharactersCellViewModelProtocol]?> { get }

    func fetchCharacterData()
}
