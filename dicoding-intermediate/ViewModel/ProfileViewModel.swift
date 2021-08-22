//
//  ProfileViewModel.swift
//  dicoding-intermediate
//
//  Created by candra restu on 22/08/21.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    
    func getLocalData() {
        self.name = UserDefaults.standard.object(forKey: "name") as? String ?? "Candra Restu Noviar"
        self.email = UserDefaults.standard.object(forKey: "email") as? String ?? "candra.restu22@gmail.com"
    }
    
    func setLocalData(name: String, email: String) {
        UserDefaults.standard.set(name, forKey: "name")
        UserDefaults.standard.set(email, forKey: "email")
        
        if name.isEmpty {
            UserDefaults.standard.removeObject(forKey: "name")
        }
        
        if email.isEmpty {
            UserDefaults.standard.removeObject(forKey: "email")
        }
    }
    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { datakey in
            defaults.removeObject(forKey: datakey)
        }
    }
}
