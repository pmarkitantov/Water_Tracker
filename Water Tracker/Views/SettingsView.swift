//
//  SettingsView.swift
//  Water Tracker
//
//  Created by Pavel Markitantov on 16/01/2024.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("waterIntakeGoal") private var waterIntakeGoal: Double = 2000 //

    var body: some View {
        ZStack {
            BackgroundView()

            VStack(spacing: 20) {
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
                HStack {
                    Text("Settings")
                        .font(.largeTitle)
                    Spacer()
                }
                Text("Set your daily water intake goal")
                    .font(.title3)

                HStack {
                    Text("\(Int(waterIntakeGoal)) ml")

                    Slider(value: $waterIntakeGoal, in: 500 ... 5000, step: 50)
                        .accentColor(.white)
                }

                Spacer()
            }
            .foregroundColor(.white)
            .padding()
        }
        .navigationBarTitle("Settings")
    }
}

#Preview {
    SettingsView()
}
