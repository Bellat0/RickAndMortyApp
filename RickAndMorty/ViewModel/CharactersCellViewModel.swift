//
//  CharactersCellViewModel.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 23.01.2024.
//

import Foundation

class CharactersCellViewModel: CharactersCellViewModelProtocol {
    var id: Int
    var name: String
    var image: String
    var status: String
    var species: String
    var type: String
    var gender: String

    init(dataSource: CharacterResult) {
        id = dataSource.id
        name = dataSource.name
        image = dataSource.image
        status = dataSource.status.rawValue
        species = dataSource.species.rawValue
        type = dataSource.type
        gender = dataSource.gender.rawValue
    }
}
