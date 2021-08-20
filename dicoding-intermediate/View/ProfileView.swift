//
//  ProfileView.swift
//  dicoding-intermediate
//
//  Created by candra restu on 21/08/21.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image("imgProfile")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200, alignment: .center)
                    .clipShape(Circle())
                Text("Candra Restu Noviar")
                    .font(.system(size: 24, weight: .bold))
                    .padding(.top, 12)
                Text("candra.restu22@gmail.com")
                    .font(.system(size: 24, weight: .regular))
                    .padding(.top, 24)
            }.navigationTitle("Profile")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
