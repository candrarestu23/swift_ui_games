//
//  FavoriteViewModel.swift
//  dicoding-intermediate
//
//  Created by candra restu on 20/08/21.
//

import Foundation
import CoreData

class FavoriteViewModel: ObservableObject {
    @Published private(set) var savedEntities: [GameEntity] = []
    @Published var games = [GameModel]()
    @Published var gameDetail: GameDetailModel?
    @Published var isLoading = false
    @Published var showAlert = false

    func getFavGames() {
        savedEntities.removeAll()
        savedEntities = CoreDataManager.shared.getAllGames()
        games.removeAll()
        let tempArray = Array(Set(savedEntities))
        for item in tempArray {
            print(item.objectID)
            let tempGame = GameModel(gameId: Int(item.gameID),
                                     name: item.name!,
                                     released: item.released!,
                                     backgroundImage: item.image!,
                                     rating: item.rate)
            
            let checkGames = games.filter({ $0.name == item.name ?? "" }).first
            if checkGames == nil {
                games.append(tempGame)
            }
        }
        isLoading = false
    }
    
    func getFavDetail(gameID: NSManagedObjectID) {
        isLoading = true
        gameDetail = nil
        let existingGmaeEntity = CoreDataManager.shared.getGameByID(gameId: gameID)
        if let data = existingGmaeEntity {
            let genres = data.genre?.split(separator: ",")
            var genreData: [GenreModel] = []
            var tagsData: [TagsModel] = []
            
            if let genreList = genres {
                for item in genreList {
                    let tempData = GenreModel(name: String(item))
                    genreData.append(tempData)
                }
            }
            
            let tags = data.tags?.split(separator: ",")

            if let tagsList = tags {
                for item in tagsList {
                    tagsData.append(TagsModel(name: String(item)))
                }
            }
            
            let developer = GenreModel(name: data.developer ?? "")
            let publisher = GenreModel(name: data.publisher ?? "")
            gameDetail = GameDetailModel(gameId: Int(data.gameID),
                                         slug: "",
                                         name: data.name,
                                         description: data.desc,
                                         released: data.released,
                                         backgroundImage: data.image,
                                         rating: data.rate,
                                         ratingTop: 5,
                                         genres: genreData,
                                         tags: tagsData,
                                         developers: [developer],
                                         publishers: [publisher])
            isLoading = false
        }
    }
    
    func removeGames(gameID: NSManagedObjectID) {
        let existingGmaeEntity = CoreDataManager.shared.getGameByID(gameId: gameID)
        if let data = existingGmaeEntity {
            CoreDataManager.shared.deleteGame(game: data)
        }
    }
    
    func searchGame(search: String) {
        games = games.filter { $0.name?.lowercased().contains(search.lowercased()) ?? true }
    }
    
    func getObjectID(_ gameID: Int16) -> NSManagedObjectID {
        let tempData = savedEntities.filter { $0.gameID == gameID }
        return tempData.first?.objectID ?? NSManagedObjectID()
    }
}
