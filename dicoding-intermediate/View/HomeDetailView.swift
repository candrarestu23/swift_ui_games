//
//  HomeDetailView.swift
//  dicoding-intermediate
//
//  Created by candra restu on 16/08/21.
//

import SwiftUI
import Kingfisher
import CoreData

struct HomeDetailView: View {
    @StateObject var viewModel = HomeViewModelImpl(service: GamesServiceImpl())
    var id = 0
    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch viewModel.state {
                case .loading:
                    ProgressView()
                case .failed(let error):
                    ErrorView(error: error,
                                  closure: {
                                    
                                  })
                case .success:
                    ScrollViewDetail(viewModel: viewModel)
                }
            }

        }
        .onAppear(perform: {
            viewModel.getDetailGames(id: id)
        })
        .alert(isPresented: $viewModel.showAlert) { () -> Alert in
            Alert(title: Text("Save Data"),
                  message: Text("Save Data to favorite success"),
                  dismissButton: .default(Text("Dismiss")))
        }
    }
}

struct ImagePlaceHolder: View {
    var body: some View {
        Image(systemName: "photo,fill")
            .foregroundColor(.white)
            .background(Color.gray)
            .frame(maxWidth: .infinity, maxHeight: 200)
    }
}

struct ScrollViewDetail: View {
    @StateObject var viewModel: HomeViewModelImpl
    
    var body: some View {
        ScrollView {
            VStack {
                if let stringURL = viewModel.gameDetail.backgroundImage,
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
                        Text(viewModel.gameDetail.name ?? "")
                            .font(.system(size: 24, weight: .regular))
                            .padding(.leading, 12)
                            .padding(.bottom, 8)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Divider()
                        HStack {
                            Text("Publisher")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(Color.gray)
                            Text(viewModel.gameDetail.publishers?[0].name ?? "")
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 12)
                        .padding(.bottom, 4)
                    
                        HStack {
                            Text("Developer")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(Color.gray)
                            Text(viewModel.gameDetail.developers?[0].name ?? "")
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 12)
                        .padding(.bottom, 4)

                        HStack {
                            Text("Released")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(Color.gray)
                            Text(viewModel.gameDetail.released ?? "")
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 12)
                        .padding(.bottom, 4)

                        Text(viewModel.gameDetail.description?.htmlToString ?? "")
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
                                if let tags = viewModel.gameDetail.tags {
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
                                if let genres = viewModel.gameDetail.genres {
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
                    Button("Save to Favorite") {
                        let data = viewModel.gameDetail
                        viewModel.addGames(id: data.id,
                                           gameID: Int16(data.gameId ?? 0),
                                           image: data.backgroundImage ?? "",
                                           name: data.name ?? "",
                                           rate: data.rating ?? 0,
                                           publisher: data.publishers?[0].name ?? "",
                                           developer: data.developers?[0].name ?? "",
                                           released: data.released ?? "",
                                           desc: data.description ?? "",
                                           tags: data.tags ?? [],
                                           genre: data.genres ?? [])
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

struct HomeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewDetail(viewModel: HomeViewModelImpl(service: GamesServiceImpl()))
    }
}
