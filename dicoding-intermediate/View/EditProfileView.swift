//
//  EditProfileView.swift
//  dicoding-intermediate
//
//  Created by candra restu on 22/08/21.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var nameText = ""
    @State var emailText = ""
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Name")
            TextField("Name", text: $nameText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 40)
            Text("Email")
            TextField("Email", text: $emailText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 40)
            Spacer()
            Button(action: {
                viewModel.setLocalData(name: nameText, email: emailText)
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Edit Profile")
            }).padding([.leading, .trailing], 20)
            .padding([.bottom, .top], 12)
            .foregroundColor(.white)
            .background(Color.blue)
            .frame(maxWidth: .infinity)
            .cornerRadius(16)
        }.padding([.leading, .trailing], 20)
        .padding(.top, 60)
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
