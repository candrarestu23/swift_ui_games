//
//  TabBarView.swift
//  dicoding-intermediate
//
//  Created by candra restu on 15/08/21.
//

import SwiftUI

struct TabBarView: View {
    
    @State var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }.tag(0)
            FavoriteView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorite")
                }.tag(1)
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }.tag(2)
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
