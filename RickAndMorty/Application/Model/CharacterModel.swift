//
//  CharacterResult.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 21.08.2023.
//

import Foundation

struct CharacterModel: Codable {
    let results: [CharacterResult]
}

struct CharacterResult: Codable {
    let name: String
    let image: String
    let status: Status
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
