//
//  ChallengeListViewModel.swift
//  Fitness App
//
//  Created by Kaiserdem on 05.07.2021.
//

import Foundation
import Combine

final class ChallengeListViewModel: ObservableObject {
    
    private let userService: UserServicesProtocol
    private let challengeService: ChallengeServiceProtocol
    private var cansellables: [AnyCancellable] = []
    
    init(
        userService: UserServicesProtocol = UserService(),
        challengeService: ChallengeServiceProtocol = ChallengeService()
    ) {
        self.userService = userService
        self.challengeService = challengeService
    }
    
    private func observeChallenges() {
        userService.currentUser()
            .compactMap { $0?.uid }
            .flatMap { userId -> AnyPublisher<[Challenge],IncrementError>  in
                return self.challengeService.observerChallenges(userId: userId)
            }.sink { (completion) in
                switch completion {
                case let .failure(error):
                    print(error.localizedDescription)
                case .finished:
                    print("Finished")
                }
            } receiveValue: { challenges in
                print(challenges)
            }.store(in: &cansellables)

        
    }
}
