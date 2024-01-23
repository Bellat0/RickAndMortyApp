//
//  CharactersCellViewModelProtocol.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 23.01.2024.
//

import Foundation

protocol CharactersCellViewModelProtocol {
    var id: Int { get }
    var name: String { get }
    var image: String { get }
    var status: String { get }
    var species: String { get }
    var type: String { get }
    var gender: String { get }
}
