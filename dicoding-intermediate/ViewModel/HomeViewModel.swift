//
//  HHomeViewModel.swift
//  dicoding-intermediate
//
//  Created by candra restu on 14/08/21.
//

import Foundation
import Combine
import CoreData

protocol HomeViewModel {
    func getGames(page: Int, pageSize: Int, search: String)
    func getDetailGames(id: Int)
}

class HomeViewModelImpl: ObservableObject, HomeViewModel {

    private let service: GamesService
    @Published var games = [GameModel]()
    @Published var gameDetail = GameDetailModel()
    private var cancellable = Set<AnyCancellable>()
    @Published private(set) var isError = false
    @Published private(set) var isLoading = false
    @Published private(set) var state: ResultState = .loading
    @Published private(set) var savedEntities: [GameEntity] = []
    private(set) var errorDesc: APIError = .unknown
    @Published var showAlert = false
    
    private var apiKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "Games-info", ofType: "plist") else {
                fatalError("Couldn't find Games-Info plist")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "API_KEY") as? String else {
                fatalError("Couldn't find API_KEY in Games-Info plist")
            }
            return value
        }
    }
    
    init(service: GamesService) {
        self.service = service
    }
    
    func getGames(page: Int, pageSize: Int, search: String = "") {
        self.state = .loading
        self.isLoading = true
        
        let cancellable = service
            .request(from: .getGames(apiKey, page, pageSize, search))
            .sink { response in
                switch response {
                case .finished:
                    self.isLoading = false
                    self.isError = false
                    self.state = .success
                case .failure(let error):
                    self.isError = true
                    self.isLoading = false
                    self.errorDesc = error
                    self.state = .failed(error: error)
                }
            } receiveValue: { response in
                guard let data = response.results else { return }
                self.games.append(contentsOf: data)
            }
        self.cancellable.insert(cancellable)
    }
    
    func getDetailGames(id: Int) {
        self.state = .loading
        self.isLoading = true
        
        let cancellable = service
            .requestDetail(from: .getGameDetail(apiKey, id))
            .sink { response in
                switch response {
                case .finished:
                    self.isLoading = false
                    self.isError = false
                    self.state = .success
                case .failure(let error):
                    self.isError = true
                    self.isLoading = false
                    self.errorDesc = error
                    self.state = .failed(error: error)
                }
            } receiveValue: { response in
                self.gameDetail = response
            }
        self.cancellable.insert(cancellable)
    }

    func getFavGames() {
        savedEntities = CoreDataManager.shared.getAllGames()
    }
    
    func addGames(id: UUID,
                  gameID: Int16,
                  image: String,
                  name: String,
                  rate: Double,
                  publisher: String,
                  developer: String,
                  released: String,
                  desc: String,
                  tags: [TagsModel],
                  genre: [GenreModel]) {
        let newGame = GameEntity(context: CoreDataManager.shared.viewContext)
        newGame.id = id
        newGame.gameID = gameID
        newGame.image = image
        newGame.name = name
        newGame.rate = rate
        newGame.publisher = publisher
        newGame.developer = developer
        newGame.released = released
        newGame.desc = desc

        var tempTags = ""
        var tempGenre = ""

        for item in tags {
            tempTags += "\(item.name ?? ""),"

        }
        for item in genre {
            tempGenre += "\(item.name ?? ""),"
        }
        newGame.tags = tempTags
        newGame.genre = tempGenre
        saveFavGame(gameID: newGame.objectID)
    }
    
    func removeGames(gameID: NSManagedObjectID) {
        let existingGmaeEntity = CoreDataManager.shared.getGameByID(gameId: gameID)
        if let data = existingGmaeEntity {
            CoreDataManager.shared.deleteGame(game: data)
        }
    }
    
    func saveFavGame(gameID: NSManagedObjectID) {
        let existingGmaeEntity = CoreDataManager.shared.getGameByID(gameId: gameID)
        if existingGmaeEntity != nil {
            CoreDataManager.shared.save()
        }
    }
}
