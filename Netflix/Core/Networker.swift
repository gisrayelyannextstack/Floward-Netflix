//
//  Networker.swift
//  Netflix
//
//  Created by Gerasim Israyelyan on 13.11.22.
//

import Foundation
import Combine

class Networker {
    func request<T: Decodable>(type: T.Type, endpoint: Endpoint) -> AnyPublisher<T, Error> {
        guard let urlRequest = try? endpoint.urlRequest() else {
            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }
        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
