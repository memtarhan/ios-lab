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
            Images()
            Divider()
            Gradients()
        }
    }
}

struct Images: View {
    var body: some View {
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

struct Gradients: View {
    var body: some View {
        VStack(spacing: 32) {
            Rectangle().fill(.blue.gradient)
                .frame(height: 200)

            Text("Hello world!")
                .padding()
                .foregroundColor(.white)
                .font(.largeTitle)
                .background(
                    LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom)
                )

            Text("Hello world!")
                .padding()
                .foregroundColor(.white)
                .font(.largeTitle)
                .background(
                    LinearGradient(gradient: Gradient(colors: [.red, .green]), startPoint: .leading, endPoint: .trailing)
                )

            Circle()
                .fill(
                    RadialGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple]), center: .center, startRadius: 50, endRadius: 100)
                )
                .frame(width: 200, height: 200)

            Circle()
                .fill(
                    AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center)
                )
                .frame(width: 200, height: 200)

            Circle()
                .strokeBorder(
                    AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center, startAngle: .zero, endAngle: .degrees(360)),
                    lineWidth: 50
                )
                .frame(width: 200, height: 200)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
