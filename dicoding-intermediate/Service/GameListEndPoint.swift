//
//  GameListEndPoint.swift
//  dicoding-intermediate
//
//  Created by candra restu on 14/08/21.
//

import Foundation

enum GamesAPI {
    case getGames(_ keyAPI: String, _ page: Int, _ pageSize: Int, _ search: String)
    case getGameDetail(_ keyAPI: String, _ id: Int)
}

extension GamesAPI: EndPointType {
    var urlRequest: URLRequest {
        switch self {
        case .getGames(let keyAPI, let page, let pageSize, let search):
            let fullURL = self.baseUrl.appendingPathComponent(self.path)
            var components =  URLComponents(string: fullURL.absoluteString)
            var params: [String: Any] = [:]
            params["key"] = keyAPI
            params["page"] = String(page)
            params["page_size"] = String(pageSize)
            params["search"] = search
            components?.queryItems = params.map { (keyAPI, value) in
                URLQueryItem(name: keyAPI, value: value as? String)
            }
            let tempComponent = components?.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
            components?.percentEncodedQuery = tempComponent
            return URLRequest(url: (components?.url!)!)
            
        case .getGameDetail(let keyAPI, _):
            let fullURL = self.baseUrl.appendingPathComponent(self.path)
            var components =  URLComponents(string: fullURL.absoluteString)
            var params: [String: Any] = [:]
            params["key"] = keyAPI
            components?.queryItems = params.map { (keyAPI, value) in
                URLQueryItem(name: keyAPI, value: value as? String)
            }
            let tempComponent = components?.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
            components?.percentEncodedQuery = tempComponent
            return URLRequest(url: (components?.url!)!)
        }
    }

    var baseUrl: URL {
        return URL(string: "https://api.rawg.io/api")!
    }

    var path: String {
        switch self {
        case .getGames:
            return "/games"
        case .getGameDetail(_, let id):
            return "/games/\(id)"
        }
    }

}
