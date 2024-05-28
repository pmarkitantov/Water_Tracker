//
//  MainView.swift
//  Water Tracker
//
//  Created by Pavel Markitantov on 15/01/2024.
//

import SwiftUI

struct MainView: View {
    @AppStorage("SelectedVolume") private var selectedVolume = 500
    @AppStorage("TotalWater") private var totalWater = 0
    @AppStorage("lastLaunchDate") private var lastDateString = ""
    @AppStorage("waterIntakeGoal") private var waterIntakeGoal: Double = 2000
    @AppStorage("waterIntakeHistory") private var waterIntakeHistory: Data = Data()
    @Environment(\.scenePhase) private var scenePhase
    
    
    @State private var showSettings: Bool = false
    var percentageCompleted: Double {
        (Double(totalWater) / waterIntakeGoal) * 100
    }
    
    init() {
        resetTotalCountIfNewDay()
    }
    
    var body: some View {
        ZStack {
            BackgroundView()
                
            VStack(spacing: 20) {
                
                headerView
                
    
                if totalWater > 0 {
                    
                    waterIntakeDashboard
                       
                }
                
                Spacer()
                Text("Select your hydration volume")
                    .foregroundStyle(.white)
                    .padding(5)
                
                waterVolumeStepper
                                
                Button {
                    totalWater += selectedVolume
                    
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                }
                .padding(15)
                Text("Click to add the amount of water")
                    .foregroundStyle(.white)
            }
            
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                    resetTotalCountIfNewDay()
                    print("onChange trigered")
                }
            }
        }
        
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
    }
    
    private func resetTotalCountIfNewDay() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDate = formatter.string(from: Date())
        
        if currentDate != lastDateString {
            totalWater = 0
            
            lastDateString = currentDate
        }
    }
}

extension MainView {
    
    var headerView: some View {
        HStack {
            Button {
                showSettings = true
            } label: {
                Image(systemName: "gear")
                    .foregroundStyle(.white)
                    .font(.title)
            }
            Spacer()
            Button {
                totalWater = 0
            } label: {
                Image(systemName: "trash")
                    .foregroundStyle(.white)
                    .font(.title)
            }
        }
        .padding(.horizontal, 25)
    }
    
    var waterIntakeDashboard: some View {
        VStack {
            Text("\(totalWater)/\(Int(waterIntakeGoal))" + "ml")
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .fontDesign(.rounded)
                .font(.largeTitle)
                .padding(.top, 25)
            Spacer()
            CircularProgressBar(totalWater: totalWater, waterIntakeGoal: waterIntakeGoal, percentageCompleted: percentageCompleted)
        }
    }
    
    var waterVolumeStepper: some View {
        HStack {
            Button {
                selectedVolume -= 50
                if selectedVolume < 0 {
                    selectedVolume = 0
                }
            } label: {
                Image(systemName: "minus.circle")
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .font(.title)
            }
            
            Text(String(selectedVolume) + "ml")
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .fontDesign(.rounded)
                .font(.largeTitle)
            
            Button {
                selectedVolume += 50
                
            } label: {
                Image(systemName: "plus.circle")
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .font(.title)
            }
        }

    }
}
#Preview {
    MainView()
}

