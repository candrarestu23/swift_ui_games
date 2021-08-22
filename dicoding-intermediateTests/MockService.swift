//
//  MockService.swift
//  dicoding-intermediateTests
//
//  Created by candra restu on 22/08/21.
//

@testable import dicoding_intermediate
import Foundation
import Combine

final class MockService: GamesService {
    
    func request(from endpoint: GamesAPI) -> AnyPublisher<GameListModel, APIError> {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "GameDataMock", ofType: "json") else {
            return Fail(error: APIError.unknown).eraseToAnyPublisher()
        }
        guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            return Fail(error: APIError.unknown).eraseToAnyPublisher()
        }
        let data = jsonString.data(using: .utf8)!
        let jsonDecoder = JSONDecoder()
        return Just(data)
            .decode(type: GameListModel.self, decoder: jsonDecoder)
            .mapError { _ in APIError.decodingError }
            .eraseToAnyPublisher()
    }
    
    func requestDetail(from endpoint: GamesAPI) -> AnyPublisher<GameDetailModel, APIError> {
        return Fail(error: APIError.unknown).eraseToAnyPublisher()
    }
    
    
}
