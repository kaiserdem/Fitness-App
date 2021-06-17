//
//  CreateView.swift
//  Fitness App
//
//  Created by Kaiserdem on 16.06.2021.
//

import SwiftUI

struct CreateView: View {
    @State private var isActive = false
    var body: some View {
        ScrollView {
            VStack {
                DropDownView()
                DropDownView()
                DropDownView()
                DropDownView()
                DropDownView()
                Spacer()
                NavigationLink(destination: RemindView(),
                               isActive: $isActive) {
                    Button(action: {
                        isActive = true
                    }){
                        Text("Next")
                            .font(.system(size: 24, weight: .medium))
                    }
                               }
            }.navigationBarTitle("Create")
            .navigationBarBackButtonHidden(true)
            .padding(.bottom, 15)
        }
    }
}
