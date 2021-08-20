//
//  NoDataView.swift
//  dicoding-intermediate
//
//  Created by candra restu on 20/08/21.
//

import SwiftUI

struct NoDataView: View {
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.icloud.fill")
                .foregroundColor(.gray)
                .font(.system(size: 50, weight: .heavy))
                .padding(.bottom, 4)
            Text("No Data On Favorite")
                .foregroundColor(.gray)
                .font(.system(size: 24))
                .multilineTextAlignment(.center)
                .padding(.bottom, 30)
        }
    }
}

struct NoDataView_Previews: PreviewProvider {
    static var previews: some View {
        NoDataView()
    }
}
