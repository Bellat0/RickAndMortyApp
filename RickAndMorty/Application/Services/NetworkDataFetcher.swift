//
//  NetworkDataFetcher.swift
//  RickAndMorty
//
//  Created by Maxim Tvilinev on 22.09.2023.
//

import Foundation

protocol DataFetcher {
    func fetchGenericJSONData<T: Decodable>(urlString: String, response: @escaping (T?) -> Void)
}

class NetworkDataFetcher: DataFetcher {

    var networking: Networking

    init(networking: Networking = NetworkService()) {
        self.networking = networking
    }

    func fetchGenericJSONData<T>(urlString: String, response: @escaping (T?) -> Void) where T : Decodable {
        networking.request(urlString: urlString) { data, error in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }

            let decoded = self.decodeJSON(type: T.self, fromData: data)
            response(decoded)
        }
    }

    func decodeJSON<T: Decodable>(type: T.Type, fromData: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = fromData else { return nil }

        do {
            let objects = try decoder.decode(type, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON: \(jsonError)")
            return nil
        }
    }
}

