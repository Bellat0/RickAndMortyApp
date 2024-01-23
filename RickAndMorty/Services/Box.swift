//
//  Box.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 23.01.2024.
//

import Foundation

class Box<T> {

    typealias Listener = (T) -> ()

    var listener: Listener?

    var value: T {
        didSet {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }

    func bind(listener: @escaping Listener) {
        self.listener = listener
        listener(value)
    }

    init(_ value: T) {
        self.value = value
    }
}
