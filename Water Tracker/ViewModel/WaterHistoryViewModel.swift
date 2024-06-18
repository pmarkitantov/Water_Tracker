//
//  DataService.swift
//  Water Tracker
//
//  Created by Pavel Markitantov on 28/05/2024.
//

import Foundation
import SwiftUI

class WaterHistoryViewModel: ObservableObject {
    @Published var waterIntakeHistory: [WaterIntakeData] = []
    
    @AppStorage("SelectedVolume") var selectedVolume = 500
    @AppStorage("TotalWater") var totalWater = 0
    @AppStorage("lastLaunchDate")  var lastDateString = ""
    @AppStorage("waterIntakeGoal") var waterIntakeGoal: Double = 2000
    
    private let dateFormatter: DateFormatter
    
    init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        loadWaterIntakeHistory()
        resetTotalCountIfNewDay()
    }
    
    func removeItem(at index: Int) {
        waterIntakeHistory.remove(at: index)
        saveWaterIntakeHistory()
    }
    
    func resetTotalCountIfNewDay() {
        let currentDate = getCurrentDateString()
        
        guard lastDateString != "" else {
            lastDateString = currentDate
            return
        }
        
        if currentDate != lastDateString {
            if totalWater != 0 {
                addWaterIntake(WaterIntakeData(date: lastDateString, amount: totalWater))
                totalWater = 0
            }
            lastDateString = currentDate
            saveWaterIntakeHistory()
        }
    }
    
    func addWaterIntake(_ data: WaterIntakeData) {
        waterIntakeHistory.append(data)
        saveWaterIntakeHistory()
    }
    
    private func getCurrentDateString() -> String {
        return dateFormatter.string(from: Date())
    }
    
    func loadWaterIntakeHistory() {
        if let savedData = UserDefaults.standard.data(forKey: "waterIntakeHistoryData") {
            do {
                let decodedData = try JSONDecoder().decode([WaterIntakeData].self, from: savedData)
                waterIntakeHistory = decodedData
            } catch {
                print("Error decoding water intake history: \(error)")
            }
        }
    }
    
    private func saveWaterIntakeHistory() {
        do {
            let encodedData = try JSONEncoder().encode(waterIntakeHistory)
            UserDefaults.standard.set(encodedData, forKey: "waterIntakeHistoryData")
        } catch {
            print("Error encoding water intake history: \(error)")
        }
    }
}
