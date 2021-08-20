//
//  TestListView.swift
//  dicoding-intermediate
//
//  Created by candra restu on 15/08/21.
//

import SwiftUI

struct TestListView: View {
    var list = ["test", "test1", "test2", "test3", "test4", "test5"]
    @State var showAlert = false
    var body: some View {
        NavigationView {
                ScrollView {
                    VStack {
                        ForEach(list, id: \.self) { item in
                            NavigationLink(destination:
                                            ContentView()) {
                                EmptyView()
                            }.buttonStyle(PlainButtonStyle())
                            Text(item)
                        }
                        
                        Button("Save to Favorite") {
                            print("Button pressed!")
                            showAlert = true
                        }.padding([.leading, .trailing], 20)
                        .padding([.bottom, .top], 12)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(16)
                    }.alert(isPresented: $showAlert) { () -> Alert in
                        Alert(title: Text("iOSDevCenters"),
                              message: Text("This Tutorial for SwiftUI Alert."),
                              primaryButton: .default(Text("Okay"), action: {
                            print("Okay Click")
                        }), secondaryButton: .default(Text("Dismiss")))
                    }
                    
                }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct TestListView_Previews: PreviewProvider {
    static var previews: some View {
        TestListView()
    }
}
