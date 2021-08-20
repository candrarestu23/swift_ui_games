//
//  GameItemView.swift
//  dicoding-intermediate
//
//  Created by candra restu on 14/08/21.
//

import SwiftUI
import Kingfisher
import CTRating

struct GameItemView: View {
    let game: GameModel
    @State var currentRating = 2
    var body: some View {
        ZStack {
            HStack(spacing: 8) {
                VStack {
                    if let stringURL = game.backgroundImage,
                       let imgUrl = URL(string: stringURL) {
                        KFImage.url(imgUrl)
                          .loadDiskFileSynchronously()
                          .cacheMemoryOnly()
                          .fade(duration: 0.25)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 60, alignment: .leading)
                            .cornerRadius(15)
                    } else {
                        PlaceHolderView()
                    }

                    Text(game.released ?? "").foregroundColor(.black)
                        .font(.system(size: 12, weight: .regular))
                }.frame(alignment: .leading)
                VStack(alignment: .leading, spacing: 4) {
                    Text(game.name ?? "")
                        .foregroundColor(.black)
                        .font(.system(size: 18, weight: .regular))
                        .frame(alignment: .leading)
                    Text("Action, Adventure, FPS")
                        .foregroundColor(.black)
                        .font(.system(size: 12, weight: .regular))
                        .frame(alignment: .trailing)
                    Spacer()
                    HStack {
                        Spacer()
                        CTRating(maxRating: 5, currentRating: $currentRating)
                            .frame(width: 150, height: 32, alignment: .bottomLeading)
                            .allowsHitTesting(false)
                    }
                }
            }.padding(.all, 8)
        }
    }
}

struct PlaceHolderView: View {
    var body: some View {
        Image(systemName: "photo,fill")
            .foregroundColor(.white)
            .background(Color.gray)
            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
    }
}

struct GameItemView_Previews: PreviewProvider {
    static var previews: some View {
        GameItemView(game: GameModel.dummyGame)
            .previewLayout(.sizeThatFits)
    }
}
