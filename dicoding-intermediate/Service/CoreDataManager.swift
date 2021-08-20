//
//  CoreDataManager.swift
//  dicoding-intermediate
//
//  Created by candra restu on 20/08/21.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let container: NSPersistentContainer
    static let shared = CoreDataManager()
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
    func getAllGames() -> [GameEntity] {
        let request: NSFetchRequest<GameEntity> = GameEntity.fetchRequest()
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func getGameByID(gameId: NSManagedObjectID) -> GameEntity? {
        do {
            return try viewContext.existingObject(with: gameId) as? GameEntity
        } catch {
            return nil
        }
    }
    
    func deleteGame(game: GameEntity) {
        viewContext.delete(game)
        save()
    }
    
    init() {
        container = NSPersistentContainer(name: "GamesContainer")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            } else {
                print("SUCCESS LOAD CORE DATA")
            }
        }
    }
}
