//
//  DataService.swift
//  Water Tracker
//
//  Created by Pavel Markitantov on 28/05/2024.
//

import Foundation



class WaterHistoryViewModel: ObservableObject {
    
    @Published var waterIntakeHistory: [WaterIntakeData] = []
    
    init() {
            self.loadWaterIntakeHistory()
        }
    
    func addWaterIntake(_ data : WaterIntakeData) {
        waterIntakeHistory.append(data)
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
    
    func saveWaterIntakeHistory() {
        do {
            let encodedData = try JSONEncoder().encode(waterIntakeHistory)
            UserDefaults.standard.set(encodedData, forKey: "waterIntakeHistoryData")
        } catch {
            print("Error encoding water intake history: \(error)")
        }
    }
}

