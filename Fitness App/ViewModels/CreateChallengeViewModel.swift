//
//  CreateChallengeViewModel.swift
//  Fitness App
//
//  Created by Kaiserdem on 17.06.2021.
//

import SwiftUI

final class CreateChallengeViewModel: ObservableObject {
    
    @Published var dropDowns: [ChallengePartViewModel] = [
        .init(type: .exercise),
        .init(type: .startAmount),
        .init(type: .increacse),
        .init(type: .length)
    ]
    
    enum Action {
        case selectedOption(index: Int)
    }
    
    var hasSelectedDropdown: Bool {
        selectedDropdownIndex != nil
    }
    
    var selectedDropdownIndex: Int? {
        dropDowns.enumerated().first(where: { $0.element.isSelected })?.offset

    }
    
    var displayedOptions: [DropDownOption] {
        guard let selectedDropdownIndex = selectedDropdownIndex else { return []}
        return dropDowns[selectedDropdownIndex].options
    }
    
    func send(_ action: Action) {
        switch action {
        case let .selectedOption(index):
            guard let selectedDropdownIndex = selectedDropdownIndex else { return }
            clearSelectedOptions()
            dropDowns[selectedDropdownIndex].options[index].isSelected = true
            clearSelectedDropdown()
        }
    }
    
    func clearSelectedOptions() {
        guard let selectedDropdownIndex = selectedDropdownIndex else { return }
        dropDowns[selectedDropdownIndex].options.indices.forEach { index in
            dropDowns[selectedDropdownIndex].options[index].isSelected = false
        }
    }
    
    func clearSelectedDropdown() {
        guard let selectedDropdownIndex = selectedDropdownIndex else { return }
        dropDowns[selectedDropdownIndex].isSelected = false
    }
}

extension CreateChallengeViewModel {
    
    struct  ChallengePartViewModel: DropDownItemProtocol {
        
        var options: [DropDownOption]
        var headerTitle: String {
            type.rawValue
        }
        var dropDownTitle: String {
            options.first(where: {$0.isSelected})?.formatted ?? ""
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
                      formatted: rawValue.capitalized,
                      isSelected: self == .pullups)
            }
        }
        
        enum StopOption: Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five
            
            var toDropdownOption: DropDownOption {
                .init(type: .number(rawValue),
                      formatted: "\(rawValue)",
                      isSelected: self == .one)
            }
        }
        
        enum IncreaseOption: Int, CaseIterable, DropdownOptionProtocol {
            case one = 1, two, three, four, five
            
            var toDropdownOption: DropDownOption {
                .init(type: .number(rawValue),
                      formatted: "+\(rawValue)",
                      isSelected: self == .one)
            }
        }
        enum StartOptions: Int, CaseIterable,  DropdownOptionProtocol {
            case one = 1, two, three, four, five
            
            var toDropdownOption: DropDownOption {
                .init(type: .number(rawValue),
                      formatted: "\(rawValue)",
                      isSelected: self == .one)
            }
        }
        
        enum LengthOption: Int, CaseIterable,  DropdownOptionProtocol {
            case seven = 7, fourteen = 14, twentyOne = 21, twentyEight = 28
            
            var toDropdownOption: DropDownOption {
                .init(type: .number(rawValue),
                      formatted: "\(rawValue) days",
                      isSelected: self == .seven)
            }
        }
    }
}
