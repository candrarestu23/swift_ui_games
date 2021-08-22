//
//  FavoriteView.swift
//  dicoding-intermediate
//
//  Created by candra restu on 20/08/21.
//

import SwiftUI

struct FavoriteView: View {
    
    @StateObject var viewModel = FavoriteViewModel()
    @State var searchString = ""
    
    func search() {
        viewModel.searchGame(search: searchString)
    }
    
    func cancel() {
        viewModel.getFavGames()
    }
    
    var body: some View {
        SearchNavigation(text: $searchString, search: search, cancel: cancel) {
            ZStack {
                if viewModel.savedEntities.isEmpty {
                    NoDataView()
                } else {
                    List {
                        ForEach(viewModel.games.indices, id: \.self) { item in
                            ZStack {
                                NavigationLink(destination:
                                                FavoriteDetailView(gameID:
                                                                    viewModel.getObjectID(
                                                                        Int16(
                                                                            viewModel.games[item].gameId ?? 0)
                                                                    ))) {
                                    EmptyView()
                                }
                                .frame(width: 0, height: 0)
                                GameItemView(game: viewModel.games[item],
                                             currentRating: Int(viewModel.games[item].rating?.rounded() ?? 0))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .background(Color(UIColor(named: "lightGray") ?? .white))
                                    .cornerRadius(15)
                                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                            }
                        }
                    }.listStyle(PlainListStyle())
                }
            }.navigationBarTitle("Favorite")
            .onAppear(perform: {
                viewModel.getFavGames()
            })
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
