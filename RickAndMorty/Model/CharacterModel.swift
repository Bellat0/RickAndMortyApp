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
    let id: Int
    let name: String
    let image: URL
    let status: Status
    let species: Species
    let type: String
    let gender: Gender
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

enum Species: String, Codable {
    case alien = "Alien"
    case human = "Human"
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}
