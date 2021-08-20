//
//  HomeView.swift
//  dicoding-intermediate
//
//  Created by candra restu on 14/08/21.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModelImpl(service: GamesServiceImpl())
    @State var page = 1
    @State var searchString = ""
    
    func search() {
        viewModel.games.removeAll()
        viewModel.getGames(page: 1, pageSize: 15, search: searchString)
    }
    
    func cancel() {
        viewModel.games.removeAll()
        viewModel.getGames(page: 1, pageSize: 15)
    }
    
    var body: some View {
        SearchNavigation(text: $searchString, search: search, cancel: cancel) {
            ZStack {
                List {
                    ForEach(viewModel.games.indices, id: \.self) { item in
                        ZStack {
                            NavigationLink(destination:
                                            HomeDetailView(id: viewModel.games[item].gameId ?? 0)) {
                                EmptyView()
                            }
                            .frame(width: 0, height: 0)
                            GameItemView(game: viewModel.games[item],
                                         currentRating: Int(viewModel.games[item].rating?.rounded() ?? 0))
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .background(Color(UIColor(named: "lightGray") ?? .white))
                                .cornerRadius(15)
                                .onAppear(perform: {
                                    if (viewModel.games.endIndex - 1) == item
                                        && !viewModel.games.isEmpty {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            page += 1
                                            viewModel.getGames(page: page, pageSize: 15)
                                        }
                                    }
                                })
                                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        }
                    }
                }.listStyle(PlainListStyle())
                ProgressView()
                    .opacity(viewModel.isLoading ? 1 : 0)
                    .frame(width: 100, height: 100)
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.black))
            
                ErrorView(error: viewModel.errorDesc,
                              closure: {
                                viewModel.games.removeAll()
                                viewModel.getGames(page: 1, pageSize: 15)
                              })
                        .opacity(viewModel.isError ? 1 : 0)
            }.navigationBarTitle("Home")
        }.onAppear(perform: {
            viewModel.games.removeAll()
            viewModel.getGames(page: 1, pageSize: 15)
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
