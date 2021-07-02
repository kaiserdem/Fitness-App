//
//  Challenge.swift
//  Fitness App
//
//  Created by Kaiserdem on 30.06.2021.
//

import Foundation

struct Challenge: Codable {
    let exercies: String
    let startAmount: Int
    let increase: Int
    let length: Int
    let userId: String
    let startDate: Date
}
