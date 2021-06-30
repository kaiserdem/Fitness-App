//
//  DropDownView.swift
//  Fitness App
//
//  Created by Kaiserdem on 16.06.2021.
//

import SwiftUI

struct DropDownView<T: DropDownItemProtocol>: View {
    @Binding var viewModel: T
    
    var actionSheet: ActionSheet {
        ActionSheet(
            title: Text("Select"),
            buttons: viewModel.options.map { option in
                return ActionSheet.Button.default(
                    Text(option.formatted)) {
                    viewModel.selectedOption = option
                }
            })
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.headerTitle)
                    .font(.system(size: 22, weight:.semibold))
                Spacer()
            }.padding(.vertical, 10)
            Button(action: {
                viewModel.isSelected = true
            }) {
                HStack {
                    Text(viewModel.dropDownTitle)
                        .font(.system(size: 28, weight:.semibold))

                    Spacer()
                    Image(systemName: "arrowtriangle.down.circle")
                        .font(.system(size: 24, weight:.medium))

                }
            }.buttonStyle(PrimaryButtonStyle(fillColor: .primaryButton))
        }
        .actionSheet(isPresented: $viewModel.isSelected) {
            actionSheet
        }
        .padding(15)
    }
}
//struct DropDownView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            DropDownView()
//        }
//        NavigationView {
//
//        DropDownView().environment(\.colorScheme, .dark)
//        }
//
//    }
//}
//
