//
//  FavoriteDetailView.swift
//  dicoding-intermediate
//
//  Created by candra restu on 20/08/21.
//

import SwiftUI
import Kingfisher
import CoreData

struct FavoriteDetailView: View {
    @StateObject var viewModel = FavoriteViewModel()
    var gameID: NSManagedObjectID
    var body: some View {
        VStack {
            if viewModel.gameDetail?.name == nil {
                ProgressView()
            } else {
                FavScrollDetailView(viewModel: viewModel, gameID: gameID)
            }
        }.onAppear(perform: {
            viewModel.getFavDetail(gameID: gameID)
        })
        .alert(isPresented: $viewModel.showAlert) { () -> Alert in
            Alert(title: Text("Delete Data"),
                  message: Text("Delete from favorite success"),
                  dismissButton: .default(Text("Dismiss")))
        }
    }
}

struct FavScrollDetailView: View {
    @StateObject var viewModel: FavoriteViewModel
    var gameID: NSManagedObjectID
    
    var body: some View {
        ScrollView {
            VStack {
                if let stringURL = viewModel.gameDetail?.backgroundImage,
                   let imgUrl = URL(string: stringURL) {
                    KFImage.url(imgUrl)
                      .loadDiskFileSynchronously()
                      .cacheMemoryOnly()
                      .fade(duration: 0.25)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .frame(height: 240)
                        .padding(.top, 0)

                } else {
                    PlaceHolderView()
                }
                Group {
                    VStack {
                        Text(viewModel.gameDetail?.name ?? "")
                            .font(.system(size: 24, weight: .regular))
                            .padding(.leading, 12)
                            .padding(.bottom, 8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Divider()
                        HStack {
                            Text("Publisher")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(Color.gray)
                            Text(viewModel.gameDetail?.publishers?[0].name ?? "")
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 12)
                        .padding(.bottom, 4)
                    
                        HStack {
                            Text("Developer")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(Color.gray)
                            Text(viewModel.gameDetail?.developers?[0].name ?? "")
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 12)
                        .padding(.bottom, 4)

                        HStack {
                            Text("Released")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(Color.gray)
                            Text(viewModel.gameDetail?.released ?? "")
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 12)
                        .padding(.bottom, 4)

                        Text(viewModel.gameDetail?.description?.htmlToString ?? "")
                            .font(.system(size: 14, weight: .regular))
                            .padding(.leading, 12)
                            .padding(.trailing, 12)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }

                Divider()
                
                Group {
                    VStack {
                        ScrollView(.horizontal) {
                            HStack {
                                Text("Tags: ")
                                if let tags = viewModel.gameDetail?.tags {
                                    ForEach(tags) { item in
                                        VStack {
                                            Text(item.name ?? "")
                                                .padding(.all, 4)
                                                .foregroundColor(
                                                    Color(UIColor(named: "BlueBold") ?? .white))
                                                .font(.system(size: 14, weight: .bold))
                                        }.background(Color(UIColor(named: "lightBlue") ?? .white))
                                        .opacity(0.3)
                                        .cornerRadius(4)
                                    }
                                }
                            }.padding(.leading, 8)
                        }
                        
                        ScrollView(.horizontal) {
                            HStack {
                                Text("Genre: ")
                                if let genres = viewModel.gameDetail?.genres {
                                    ForEach(genres) { genre in
                                        VStack {
                                            Text(genre.name ?? "")
                                                .padding(.all, 4)
                                                .foregroundColor(
                                                    Color(UIColor(named: "BlueBold") ?? .white))
                                                .font(.system(size: 14, weight: .bold))
                                        }.background(Color(UIColor(named: "lightBlue") ?? .white))
                                        .opacity(0.3)
                                        .cornerRadius(4)
                                    }
                                }
                            }.padding(.leading, 8)
                        }
                    }
                }

                VStack {
                    Button("Delete from Favorite") {
                        viewModel.removeGames(gameID: gameID)
                        viewModel.showAlert = true
                    }.padding([.leading, .trailing], 20)
                    .padding([.bottom, .top], 12)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(16)
                }.padding(.top, 20)

            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 60)
        }
        .frame(maxWidth: .infinity)
        .navigationTitle("Detail")
        .background(Color.white)
    }
}

struct FavoriteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteDetailView( gameID: NSManagedObjectID())
    }
}
