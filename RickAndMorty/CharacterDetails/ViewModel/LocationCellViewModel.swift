//
//  LocationCellViewModel.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 23.01.2024.
//

import Foundation

class LocationCellViewModel: LocationCellViewModelProtocol {
    var name: String
    var type: String
    var residents: [String]
    
    init(dataSource: LocationResult) {
        name = dataSource.name
        type = dataSource.type
        residents = dataSource.residents
    }
}
