//
//  GameListModel.swift
//  dicoding-intermediate
//
//  Created by candra restu on 14/08/21.
//

import Foundation

struct GameListModel: Codable {
    var results: [GameModel]?

    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct GameModel: Codable, Identifiable, Equatable {
    var id = UUID()
    var gameId: Int?
    var slug: String?
    var name: String?
    var released: String?
    var backgroundImage: String?
    var rating: Double?
    var ratingTop: Int?
    
    enum CodingKeys: String, CodingKey {
        case gameId = "id"
        case slug, name, released
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
    }
    
    init(gameId: Int, name: String, released: String, backgroundImage: String, rating: Double) {
        self.gameId = gameId
        self.name = name
        self.released = released
        self.backgroundImage = backgroundImage
        self.rating = rating
    }
}

struct GenreModel: Codable, Identifiable {
    var id = UUID()
    var genreId: Int?
    var name: String?
    var slug: String?
    var gamesCount: Int?
    var imageBackground: String?

    enum CodingKeys: String, CodingKey {
        case genreId = "id"
        case name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
    
    init(name: String) {
        self.name = name
    }
}

struct TagsModel: Codable, Identifiable {
    var id = UUID()
    var tagsId: Int?
    var name: String?
    var slug: String?
    var language: String?
    var gamesCount: Int?
    var imageBackground: String?
    
    enum CodingKeys: String, CodingKey {
        case tagsId = "id"
        case name, slug, language
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
    
    init(name: String) {
        self.name = name
    }
}

struct PubliserModel: Codable, Identifiable {
    var id = UUID()
    var publisherID: Int?
    var name: String?
    var slug: String?
    var gamesCount: Int?
    var imageBackground: String?
    
    enum CodingKeys: String, CodingKey {
        case publisherID = "id"
        case name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}

extension GameModel {

    static var dummyGame: GameModel {
        .init(gameId: 1,
              name: "Bioshock: Infinite",
              released: "11-11-1111",
              backgroundImage: "https://media.rawg.io/media/games/fc1/fc1307a2774506b5bd65d7e8424664a7.jpg",
              rating: 4)
    }
}
