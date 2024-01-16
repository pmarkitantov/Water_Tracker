//
//  MainView.swift
//  Water Tracker
//
//  Created by Pavel Markitantov on 15/01/2024.
//

import SwiftUI

struct MainView: View {
    init() {
        resetTotalCountIfNewDay()
    }
    
    @AppStorage("SelectedVolume") private var selectedVolume = 500
    @AppStorage("TotalWater") private var totalWater = 0
    @AppStorage("lastLaunchDate") private var lastDateString = ""
    
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
                    Button {} label: {
                        Image(systemName: "person.circle")
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
                    
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                }
                .padding(25)
            }
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
