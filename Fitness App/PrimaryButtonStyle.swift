//
//  PrimaryButtonStyle.swift
//  Fitness App
//
//  Created by Kaiserdem on 16.06.2021.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    
    var fillColor: Color = .darckPrimaryButton
    
    func makeBody(configuration: Configuration) -> some View {
        return PrimaryButton(configuration: configuration,
                             fillColor: fillColor)
    }
    
    struct PrimaryButton: View {
        
        let configuration: Configuration
        let fillColor: Color
        
        var body: some View {
            return configuration.label
                .padding(20)
                .background(
                    RoundedRectangle(
                        cornerRadius: 8
                    ).fill(
                        fillColor
                    )
                )
        }
    }
}

struct PrimaryButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
            Text("Create a challenge")
        })
        .buttonStyle(PrimaryButtonStyle())
    }
}
