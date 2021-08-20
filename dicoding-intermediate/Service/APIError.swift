//
//  APIError.swift
//  dicoding-intermediate
//
//  Created by candra restu on 14/08/21.
//

import Foundation

enum APIError: Error {
    case decodingError
    case errorCode(Int)
    case unknown
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Failed to Decode Object"
        case .errorCode(let code):
            return "\(code) - please try again later"
        case .unknown:
            return "Unknown Error"
        }
    }
}
