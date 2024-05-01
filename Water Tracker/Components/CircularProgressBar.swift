//
//  CircularProgressBar.swift
//  Water Tracker
//
//  Created by Pavel Markitantov on 16/01/2024.
//

import SwiftUI

struct CircularProgressBar: View {
    var totalWater = 500
    var waterIntakeGoal = 2000.0
    var percentageCompleted = 0.0
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(.systemGray3), lineWidth: 20)
                .frame(width: 250, height: 250)
            Circle()
                .trim(from: 0, to: Double(totalWater) / waterIntakeGoal)
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [Color.orange, Color.yellow, Color.green, Color.green]),
                        center: .center,
                        startAngle: .degrees(0),
                        endAngle: .degrees(360)
                    ),
                    lineWidth: 20
                )
                .frame(width: 250, height: 250)
                .rotationEffect(.degrees(90))
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
            if percentageCompleted >= 100 {
                Circle()
                    .stroke(Color.green, lineWidth: 20)
                    .frame(width: 250, height: 250)
            }
        }
    }
}

#Preview {
    CircularProgressBar()
}
