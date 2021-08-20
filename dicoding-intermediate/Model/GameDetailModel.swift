//
//  GameDetailModel.swift
//  dicoding-intermediate
//
//  Created by candra restu on 16/08/21.
//

import Foundation

struct GameDetailModel: Codable, Identifiable {
    var id = UUID()
    var gameId: Int?
    var slug: String?
    var name: String?
    var description: String?
    var released: String?
    var backgroundImage: String?
    var rating: Double?
    var ratingTop: Int?
    var genres: [GenreModel]?
    var tags: [TagsModel]?
    var developers: [GenreModel]?
    var publishers: [GenreModel]?
    
    enum CodingKeys: String, CodingKey {
        case gameId = "id"
        case slug, name, released
        case description, developers, publishers
        case backgroundImage = "background_image"
        case rating, genres, tags
        case ratingTop = "rating_top"
    }
}
