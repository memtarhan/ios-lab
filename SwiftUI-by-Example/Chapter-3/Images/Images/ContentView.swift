//
//  ContentView.swift
//  Images
//
//  Created by Mehmet Tarhan on 02/05/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    Image("image2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }

                VStack {
                    Image(systemName: "cloud.sun.rain.fill")
                        .renderingMode(.original)
                        .font(.largeTitle)
                        .padding()
                        .background(.black)
                        .clipShape(Circle())
                }

                VStack {
                    Image(systemName: "person.crop.circle.fill.badge.plus")
                        .renderingMode(.original)
                        .foregroundColor(.blue)
                        .font(.largeTitle)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
