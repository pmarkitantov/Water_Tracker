//
//  SettingsView.swift
//  Water Tracker
//
//  Created by Pavel Markitantov on 16/01/2024.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("waterIntakeGoal") private var waterIntakeGoal: Double = 2000 

    var body: some View {
        ZStack {
            BackgroundView()
            

            VStack(spacing: 20) {
                navigationBar
                titleText
                intakeSelectionBar
                Spacer()
            }
            .foregroundColor(.white)
            .padding()
        }

    }
}

extension SettingsView {
    
    var intakeHistory: some View {
        Group {
            List {
                
            }
        }
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
    }
    
    var titleText: some View {
        HStack {
            Text("Settings")
                .font(.largeTitle)
            Spacer()
        }
    }
}

#Preview {
    SettingsView()
}
