//
//  ChallengeListView.swift
//  Fitness App
//
//  Created by Kaiserdem on 05.07.2021.
//

import SwiftUI

struct ChallengeListView: View {
    
    @StateObject private var viewModel = ChallengeListViewModel()
    
    var body: some View {
        Text("Challenge List")
    }
}
