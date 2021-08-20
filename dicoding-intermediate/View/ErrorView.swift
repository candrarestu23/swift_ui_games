//
//  ErrorView.swift
//  dicoding-intermediate
//
//  Created by candra restu on 14/08/21.
//

import SwiftUI

struct ErrorView: View {

    let error: Error
    let closure: EmptyClosure
    
    internal init(error: Error, closure: @escaping EmptyClosure) {
        self.error = error
        self.closure = closure
    }
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.icloud.fill")
                .foregroundColor(.gray)
                .font(.system(size: 50, weight: .heavy))
                .padding(.bottom, 4)
            Text(error.localizedDescription)
                .foregroundColor(.gray)
                .font(.system(size: 15))
                .multilineTextAlignment(.center)
                .padding(.bottom, 30)
            Button(action: {
                closure()
            }, label: {
                Text("Retry")
            }).padding(.vertical, 12)
            .padding(.horizontal, 30)
            .background(Color.blue)
            .foregroundColor(.white)
            .font(.system(size: 15, weight: .heavy))
            .cornerRadius(10)
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: APIError.decodingError) {}
            .previewLayout(.sizeThatFits)
    }
}
