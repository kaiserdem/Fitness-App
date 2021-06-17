//
//  RemindView.swift
//  Fitness App
//
//  Created by Kaiserdem on 17.06.2021.
//

import SwiftUI

struct RemindView: View {
    //@State private var isActive = false
    var body: some View {
        VStack {
            Spacer()
            //DropDownView()
            Spacer()
            Button(action: {}) {
                Text("Create")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.primary)
            }.padding(.bottom, 10)
            Button(action: {}) {
                Text("Skip")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.primary)
                
            }
        }.navigationTitle("Remined")
        .padding(.bottom, 15)

    }
}

struct RemindView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RemindView()
            
        }
    }
}
