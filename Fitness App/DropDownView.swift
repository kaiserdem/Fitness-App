//
//  DropDownView.swift
//  Fitness App
//
//  Created by Kaiserdem on 16.06.2021.
//

import SwiftUI

struct DropDownView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Exercise")
                    .font(.system(size: 22, weight:.semibold))
                Spacer()
            }.padding(.vertical, 10)
            Button(action: {}) {
                HStack {
                    Text("Pushups")
                        .font(.system(size: 28, weight:.semibold))

                    Spacer()
                    Image(systemName: "arrowtriangle.down.circle")
                        .font(.system(size: 24, weight:.medium))

                }
            }.buttonStyle(PrimaryButtonStyle(fillColor: .primaryButton))
        }.padding(15)
    }
}
struct DropDownView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DropDownView()
        }
        NavigationView {

        DropDownView().environment(\.colorScheme, .dark)
        }

    }
}

