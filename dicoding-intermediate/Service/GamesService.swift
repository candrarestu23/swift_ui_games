//
//  GamesService.swift
//  dicoding-intermediate
//
//  Created by candra restu on 14/08/21.
//

import Foundation
import Combine

protocol GamesService {
    func request(from endpoint: GamesAPI) -> AnyPublisher<GameListModel, APIError>
    func requestDetail(from endpoint: GamesAPI) -> AnyPublisher<GameDetailModel, APIError>
}

struct GamesServiceImpl: GamesService {
    func requestDetail(from endpoint: GamesAPI) -> AnyPublisher<GameDetailModel, APIError> {
        return URLSession
            .shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { _ in APIError.unknown }
            .flatMap { data, response -> AnyPublisher<GameDetailModel, APIError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                
                if (200...299).contains(response.statusCode) {
                    let jsonDecoder = JSONDecoder()
                    return Just(data)
                        .decode(type: GameDetailModel.self, decoder: jsonDecoder)
                        .mapError { _ in APIError.decodingError }
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
    func request(from endpoint: GamesAPI) -> AnyPublisher<GameListModel, APIError> {
        return URLSession
            .shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { _ in APIError.unknown }
            .flatMap { data, response -> AnyPublisher<GameListModel, APIError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                
                if (200...299).contains(response.statusCode) {
                    let jsonDecoder = JSONDecoder()
                    return Just(data)
                        .decode(type: GameListModel.self, decoder: jsonDecoder)
                        .mapError { _ in APIError.decodingError }
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
}
