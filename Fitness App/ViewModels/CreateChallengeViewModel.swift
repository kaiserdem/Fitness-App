//
//  CreateChallengeViewModel.swift
//  Fitness App
//
//  Created by Kaiserdem on 17.06.2021.
//

import SwiftUI
import Combine

typealias  UserId = String

final class CreateChallengeViewModel: ObservableObject {
    
    @Published var exerciseDropdown = ChallengePartViewModel(type: .exercise)
    @Published var startAmountDropdown = ChallengePartViewModel(type: .startAmount)
    @Published var increacseDropdown = ChallengePartViewModel(type: .increacse)
    @Published var lengthDropdown = ChallengePartViewModel(type: .length)

    
    private let userService: UserServicesProtocol
    private var cancellables: [AnyCancellable] = []
    private let challengeService: ChallengeServiceProtocol
    
    enum Action {
        case createChallenge
    }
    
    
    init(userService: UserServicesProtocol = UserService(),
         challengeService: ChallengeServiceProtocol = ChallengeService()) {
        self.userService = userService
        self.challengeService = challengeService
    }
    
    func send(_ action: Action) {
        switch action {
        case .createChallenge:
            currentUserId().flatMap { userId -> AnyPublisher<Void, Error> in
                return self.createChallenge(userId: userId)
            }.sink { completion in
                switch completion {
                case let  .failure(error):
                    print(error.localizedDescription)
                case .finished:
                    print("Finished")
                }
            } receiveValue: { (_) in
                print("Success")
            }.store(in: &cancellables)
        }
    }
    
    private func createChallenge(userId: UserId) -> AnyPublisher<Void, Error> {
        guard let exercise = exerciseDropdown.text,
              let startAmount = startAmountDropdown.number,
              let increase = increacseDropdown.number,
              let length = lengthDropdown.number else {
            return Fail(error: NSError()).eraseToAnyPublisher()
        }
        let challenge = Challenge(
            exercies: exercise,
            startAmount: startAmount,
            increase: increase,
            length: length,
            userId: userId,
            startDate: Date()
        )
        return challengeService.create(challenge).eraseToAnyPublisher()
    }
    
    private func currentUserId() -> AnyPublisher<UserId, Error> {
        print("getting user id")
        return userService.currentUser().flatMap { user -> AnyPublisher<UserId,Error> in
            if let user = user?.uid {
                print("user if logged in...")
                return Just(user)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            } else {
                print("user is begin logged in annomously...")
                return self.userService
                    .signInAnonymously()
                    .map { $0.uid }
                    .eraseToAnyPublisher()
            }
        }.eraseToAnyPublisher()
    }
}

extension CreateChallengeViewModel {
    
    struct  ChallengePartViewModel: DropDownItemProtocol {
        var selectedOption: DropDownOption
        
        
        var options: [DropDownOption]
        var headerTitle: String {
            type.rawValue
        }
        var dropDownTitle: String {
            selectedOption.formatted
        }
        var isSelected: Bool = false
        
        private let type: ChallengePartType
        
        init(type: ChallengePartType) {
            
            switch type {
            case .exercise:
                self.options = ExerciseOption.allCases.map { $0.toDropdownOption }
            case .startAmount:
                self.options = StartOptions.allCases.map { $0.toDropdownOption }
            case .increacse:
                self.options = IncreaseOption.allCases.map { $0.toDropdownOption }
            case .length:
                self.options = LengthOption.allCases.map { $0.toDropdownOption }

            }
            self.type = type
            self.selectedOption = options.first!
            
        }
        
        enum ChallengePartType: String, CaseIterable {
            case exercise = "Exercise"
            case startAmount = "Starting Amount"
            case increacse = "Daily Increase"
            case length = "Challenge Length"
            
        }
        
        enum ExerciseOption: String, CaseIterable, DropdownOptionProtocol {
            case pullups
            case pushups
            case situps
            
            var toDropdownOption: DropDownOption {
                .init(type: .text(rawValue),
                      formatted: rawValue.capitalized
                )
            }
        }
        
        enum StopOption: Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five
            
            var toDropdownOption: DropDownOption {
                .init(type: .number(rawValue),
                      formatted: "\(rawValue)"
                )
            }
        }
        
        enum IncreaseOption: Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five
            
            var toDropdownOption: DropDownOption {
                .init(type: .number(rawValue),
                      formatted: "+\(rawValue)"
                )
            }
        }
        enum StartOptions: Int, CaseIterable,  DropdownOptionProtocol {
            case one = 1, two, three, four, five
            
            var toDropdownOption: DropDownOption {
                .init(type: .number(rawValue),
                      formatted: "\(rawValue)"
                )
            }
        }
        
        enum LengthOption: Int, CaseIterable,  DropdownOptionProtocol {
            case seven = 7, fourteen = 14, twentyOne = 21, twentyEight = 28
            
            var toDropdownOption: DropDownOption {
                .init(type: .number(rawValue),
                      formatted: "\(rawValue) days"
                )
            }
        }
    }
}

extension CreateChallengeViewModel.ChallengePartViewModel {
    var text: String? {
        if case let .text(text) = selectedOption.type {
            return text
        }
        return nil
    }
    
    var number: Int? {
        if case let .number(number) = selectedOption.type {
            return number
        }
        return nil
    }
}
