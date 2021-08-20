//
//  dicoding_intermediateApp.swift
//  dicoding-intermediate
//
//  Created by candra restu on 14/08/21.
//

import SwiftUI

@main
struct DicodingIntermediateApp: App {
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environment(\.managedObjectContext
                             , CoreDataManager.shared.viewContext)
        }
    }
}
