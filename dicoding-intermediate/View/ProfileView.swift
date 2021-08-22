//
//  ProfileView.swift
//  dicoding-intermediate
//
//  Created by candra restu on 21/08/21.
//

import SwiftUI

struct ProfileView: View {
    @State var isButtonClicked = false
    @StateObject var viewModel = ProfileViewModel()

    var body: some View {
        NavigationView {
                VStack {
                    Image("imgProfile")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200, alignment: .center)
                        .clipShape(Circle())
                    Text(viewModel.name)
                        .font(.system(size: 24, weight: .bold))
                        .padding(.top, 12)
                    Text(viewModel.email)
                        .font(.system(size: 24, weight: .regular))
                        .padding(.top, 24)
                    
                        Button(action: {
                            self.isButtonClicked = true
                        }, label: {
                            Text("Edit Profile")
                        }).padding(.top, 40)
                }.navigationTitle("Profile")
                .background(
                    NavigationLink(
                        destination: EditProfileView(),
                        isActive: $isButtonClicked,
                        label: {
                            EmptyView()
                        }).frame(width: 0, height: 0)
                ).onAppear(perform: {
                    viewModel.getLocalData()
                })
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
