//
//  dicoding_intermediateTests.swift
//  dicoding-intermediateTests
//
//  Created by candra restu on 22/08/21.
//

import XCTest
import CoreData
@testable import dicoding_intermediate

class dicoding_intermediateTests: XCTestCase {
    
    var viewModel: HomeViewModelImpl!
    var viewModelFav: FavoriteViewModel!
    var viewModelProfile: ProfileViewModel!
    var mockService: MockService!
    
    override func setUp() {
        mockService = MockService()
        viewModel = .init(service: mockService)
        viewModelFav = .init()
        viewModelProfile = .init()
    }
    
    func test_get_games() {
        viewModel.getGames(page: 1, pageSize: 15)
        XCTAssertEqual(viewModel.games.count, 15)
        XCTAssertEqual(viewModel.games.first?.name, "Grand Theft Auto V")
        XCTAssertEqual(viewModel.games[1].name, "The Witcher 3: Wild Hunt")
        XCTAssertEqual(viewModel.games[2].name, "Portal 2")
    }
    
    func test_get_games_failed() {
        viewModel.getDetailGames(id: 1)
        XCTAssert(viewModel.isError)
    }
    
    func test_get_list_favorite() {
        viewModelFav.getFavGames()
        XCTAssertNotNil(viewModelFav.savedEntities)
    }
    
    func test_get_fav_detail() {
        viewModelFav.getFavGames()
        XCTAssertNotNil(viewModelFav.savedEntities)
        let firstGmaes = viewModelFav.savedEntities[0]
        let objectID = viewModelFav.getObjectID(firstGmaes.gameID)
        XCTAssertNotNil(objectID)
        viewModelFav.getFavDetail(gameID: objectID)
        XCTAssertNotNil(viewModelFav.gameDetail)
        XCTAssertEqual(viewModelFav.gameDetail?.name, "The Witcher 3: Wild Hunt")
    }
    
    func test_search_fav_games() {
        viewModelFav.getFavGames()
        XCTAssertNotNil(viewModelFav.savedEntities)
        viewModelFav.searchGame(search: "The Witcher 3: Wild Hunt")
        XCTAssertNotNil(viewModelFav.games)
        XCTAssertEqual(viewModelFav.games.first?.name, "The Witcher 3: Wild Hunt")
    }
    
    func test_save_userdefault() {
        viewModelProfile.setLocalData(name: "Candra", email: "candra@gmail.com")
        let name = UserDefaults.standard.object(forKey: "name") as? String ?? ""
        let email = UserDefaults.standard.object(forKey: "email") as? String ?? ""
        XCTAssertEqual(name, "Candra")
        XCTAssertEqual(email, "candra@gmail.com")
    }
}
