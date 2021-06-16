//
//  ContentView.swift
//  Fitness App
//
//  Created by Kaiserdem on 16.06.2021.
//

import SwiftUI

struct LandingView: View {
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Spacer().frame(height:proxy.size.height * 0.18)
                Text("Fitness")
                    .font(.system(size: 64, weight: .medium))
                    .foregroundColor(.white)
                Spacer()
                Button(action: {}) {
                    HStack(spacing: 15) {
                        Spacer()
                        Image(systemName: "plus.circle")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                        Text("Create a challange")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                        Spacer()
                    }
                }
                .padding(.horizontal, 15)
                .buttonStyle(PrimaryButtonStyle())

            }.frame(maxWidth: .infinity,
                   maxHeight: .infinity)
            
            .background(
                Image("ima1")
                            .resizable()
                            .aspectRatio(contentMode: .fill
                            )
                    .overlay(Color.black.opacity(0.4))
                    .frame(width: proxy.size.width)
                    .edgesIgnoringSafeArea(.all)
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView().previewDevice("iPhone 8")
        LandingView().previewDevice("iPhone 11")
        LandingView().previewDevice("iPhone 11 Pro Max")
    }
}
