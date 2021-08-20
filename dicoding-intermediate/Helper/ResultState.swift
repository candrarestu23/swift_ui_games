//
//  ResultState.swift
//  dicoding-intermediate
//
//  Created by candra restu on 14/08/21.
//

import Foundation

enum ResultState {
    case loading
    case success
    case failed(error: Error)
}
