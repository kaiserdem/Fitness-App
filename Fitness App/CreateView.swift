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
        
    }
    
    var mainContentView: some View {
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
        }
    }
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                mainContentView
            }
        }.alert(isPresented: Binding<Bool>.constant($viewModel.error.wrappedValue != nil)) {
            Alert(
                title: Text("Error!"),
                message: Text($viewModel.error.wrappedValue?.localizedDescription ?? ""),
                dismissButton: .default(Text("OK"), action: {
                    viewModel.error = nil
                })
            )
        }
        .navigationBarTitle("Create")
        .navigationBarBackButtonHidden(true)
        .padding(.bottom, 15)
    }
}
