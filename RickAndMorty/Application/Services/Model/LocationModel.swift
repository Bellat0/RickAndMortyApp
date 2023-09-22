//
//  LocationResult.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 21.08.2023.
//

import Foundation

struct LocationModel: Decodable {
    let results: [LocationResult]
}

struct LocationResult: Decodable {
    let id: Int
    let name: String
    let type: String
    let residents: [String]
}
