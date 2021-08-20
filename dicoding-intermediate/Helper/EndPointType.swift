//
//  EndPointType.swift
//  dicoding-intermediate
//
//  Created by candra restu on 14/08/21.
//

import Foundation

protocol EndPointType {
    var urlRequest: URLRequest { get }
    var baseUrl: URL { get }
    var path: String { get }
}
