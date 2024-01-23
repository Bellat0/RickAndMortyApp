//
//  LocationCellViewModelProtocol.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 23.01.2024.
//

import Foundation

protocol LocationCellViewModelProtocol {
    var name: String { get }
    var type: String { get }
    var residents: [String] { get }
}
