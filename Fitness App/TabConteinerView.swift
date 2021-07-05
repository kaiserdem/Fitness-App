//
//  TabConteinerView.swift
//  Fitness App
//
//  Created by Kaiserdem on 05.07.2021.
//

import SwiftUI

struct TabConteinerView: View {
    
    @StateObject private var tabContainerViewModel = TabConteinerViewModel()
    
    
    var body: some View {
        TabView(selection: $tabContainerViewModel.selectedTab) {
            ForEach(tabContainerViewModel.tabItemsViewModels, id:\.self) { viewModel in
                tabView(for: viewModel.type)
                    .tabItem {
                        Image(systemName: viewModel.imageName)
                        Text(viewModel.title)
                    }
                    .tag(viewModel.type)
            }
        }.accentColor(.primary)
    }
    
    @ViewBuilder
    func tabView(for tabItemView: TabItemViewModel.TabItemType) -> some View {
        switch tabItemView {
        case .log:
            Text("Log")
        case .challengeList:
            NavigationView {
                ChallengeListView()
            }
            Text("Challenge List")
        case .settings:
            Text("Settings")
        }
    }
}

final class TabConteinerViewModel: ObservableObject {
    
    @Published var selectedTab: TabItemViewModel.TabItemType = .challengeList
    
    let tabItemsViewModels = [
        TabItemViewModel(imageName: "book", title: "Activity Log", type: .log),
        .init(imageName: "list.bullet", title: "Challenges", type: .challengeList),
        .init(imageName: "gear", title: "Settings", type: .settings)
    ]
}

struct  TabItemViewModel: Hashable {
     
    let imageName: String
    let title: String
    let type: TabItemType
    
    enum TabItemType {
        case log
        case challengeList
        case settings
    }
}
