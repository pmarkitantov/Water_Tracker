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
    @State private var showSettings: Bool = false
    var percentageCompleted: Double {
        (Double(totalWater) / waterIntakeGoal) * 100
    }

    var body: some View {
        ZStack {
            Group {
                Color("mainBlue")
                TrapezoidShape()
                    .fill(Color("secondaryBlue"))
            }
            .ignoresSafeArea()
            
            VStack {
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
    
                if totalWater > 0 {
                    HStack {
                        Text(String(totalWater) + "ml")
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                            .font(.largeTitle)
                    }
                    .padding(.top, 50)
                    Spacer()
                    ZStack {
                        Circle()
                            .stroke(Color(.systemGray), lineWidth: 20)
                            .frame(width: 250, height: 250)
                        Circle()
                            .trim(from: 0, to: 0.85)
                            .stroke(
                                AngularGradient(
                                    gradient: Gradient(colors: [Color.white, Color.green]),
                                    center: .center,
                                    startAngle: .degrees(0),
                                    endAngle: .degrees(360)
                                ), lineWidth: 20
                            )
                            .frame(width: 250, height: 250)
                            .overlay {
                                VStack {
                                    Text(String(format: "%.0f%%", percentageCompleted))
                                        .font(.system(size: 40, weight: .bold, design: .rounded))
                                    
                                    Text("Of Day Goal Completed")
                                        .fontWeight(.bold)
                                        .fontDesign(.rounded)
                                }
                                .foregroundStyle(.white)
                            }
                    }
                }
                
                Spacer()
                HStack {
                    if selectedVolume > 0 {
                        Button {
                            selectedVolume -= 100
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
                    }
                    
                    Text(String(selectedVolume) + "ml")
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .font(.largeTitle)
                    
                    Button {
                        selectedVolume += 100
                        
                    } label: {
                        Image(systemName: "plus.circle")
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                            .font(.title)
                    }
                }
                
                Button {
                    totalWater += selectedVolume
//                    calculatePercentageCompleted()
                    
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                }
                .padding(25)
                Text("Click to add the amount of water")
                    .foregroundStyle(.white)
            }
        }
        .onAppear {
            resetTotalCountIfNewDay()
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

#Preview {
    MainView()
}
