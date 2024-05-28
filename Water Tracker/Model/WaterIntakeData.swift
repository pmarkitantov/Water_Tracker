//
//  WaterIntakeData.swift
//  Water Tracker
//
//  Created by Pavel Markitantov on 28/05/2024.
//

import Foundation

struct WaterIntakeData: Codable, Identifiable {
    var id = UUID()
    let date: String
    let amount: Int
}
