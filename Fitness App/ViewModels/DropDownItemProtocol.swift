//
//  DropDownItemProtocol.swift
//  Fitness App
//
//  Created by Kaiserdem on 17.06.2021.
//

import Foundation

protocol DropDownItemProtocol {
    var options: [DropDownOption] { get }
    var headerTitle: String { get }
    var dropDownTitle: String { get }
    var isSelected: Bool { get set }
}

protocol DropdownOptionProtocol {
    var toDropdownOption: DropDownOption { get }
}

struct DropDownOption {
    enum DropDownOptionType {
        case text(String)
        case number(Int)
    }
    let type: DropDownOptionType
    let formatted: String
    var isSelected: Bool
}
