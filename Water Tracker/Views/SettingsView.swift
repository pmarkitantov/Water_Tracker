//
//  SettingsView.swift
//  Water Tracker
//
//  Created by Pavel Markitantov on 16/01/2024.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm: WaterHistoryViewModel
    @AppStorage("waterIntakeGoal") private var waterIntakeGoal: Double = 2000

    var body: some View {
        ZStack {
            BackgroundView()
            

            VStack {
                navigationBar
                titleText
                intakeSelectionBar
                if !vm.waterIntakeHistory.isEmpty {
                    HStack {
                        Text("History")
                            .font(.headline)
                            .padding(.horizontal)
                        Spacer()
                    }
                    intakeHistory
                       
                        
                }
            }
            
            .foregroundColor(.white)
            .padding()
            
           
        }

    }
}

extension SettingsView {
    
    var intakeHistory: some View {
        List(vm.waterIntakeHistory) { intakeData in
            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Text("Date: \(intakeData.date)")
                    Text("Amount of water: \(intakeData.amount)")
                }
                Spacer()
                
            }
            .frame(maxWidth: .infinity)
            .listRowBackground(Color.clear)
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.white, lineWidth: 2)
            }
            .background(Color.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 15))
                
                
        }
        .listStyle(.plain) // Устанавливаем стиль списка

    }
    
    var intakeSelectionBar: some View {
        Group {
            Text("Set your daily water intake goal")
                .font(.title3)
            HStack {
                Text("\(Int(waterIntakeGoal)) ml")

                Slider(value: $waterIntakeGoal, in: 500 ... 5000, step: 50)
                    .accentColor(.white)
            }
        }
        .padding()
        
    }
    
    var navigationBar: some View {
        HStack {
            Spacer()
            Button {
                dismiss()
            } label: {
                Text("Save")
                    .padding(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.white, lineWidth: 2)
                    }
            }
        }
        .padding(.horizontal)
    }
    
    var titleText: some View {
        
        HStack {
            Text("Settings")
                .font(.largeTitle)
            Spacer()
        }
        .padding()
           
        
    }
}

#Preview {
    SettingsView()
        .environmentObject(WaterHistoryViewModel())
}
