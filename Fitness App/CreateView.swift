//
//  CreateView.swift
//  Fitness App
//
//  Created by Kaiserdem on 16.06.2021.
//

import SwiftUI

struct CreateView: View {
    
    @StateObject var viewModel = CreateChallengeViewModel()
    @State private var isActive = false
    
    var dropdownList: some View {
        Group {
            DropDownView(viewModel: $viewModel.exerciseDropdown)
            DropDownView(viewModel: $viewModel.startAmountDropdown)
            DropDownView(viewModel: $viewModel.increacseDropdown)
            DropDownView(viewModel: $viewModel.lengthDropdown)
        }
        
//        ForEach(viewModel.dropDowns.indices, id: \.self) { index in
//            DropDownView(viewModel: $viewModel.dropDowns[index])
//        }
    }
    
    
    var body: some View {
        ScrollView {
            VStack {
                dropdownList
                Spacer()
                Button(action: {
                    viewModel.send(.createChallenge)
                }){
                    Text("Create")
                        .font(.system(size: 24, weight: .medium))
                }
            }
            .navigationBarTitle("Create")
            .navigationBarBackButtonHidden(true)
            .padding(.bottom, 15)
        }
    }
}
