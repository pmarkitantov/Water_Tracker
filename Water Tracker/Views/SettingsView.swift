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
    @State private var showAlert = false
    @State private var itemToDelete: Int?

    var body: some View {
        ZStack {
            BackgroundView()

            VStack {
                navigationBar
                titleText
                intakeSelectionBar
                historySection
                Spacer()
            }
            .foregroundColor(.white)
            .padding()
        }
        .onAppear {
            vm.loadWaterIntakeHistory()
        }
        .alert(isPresented: $showAlert) {
            deletionAlert
        }
    }

    var deletionAlert: Alert {
        Alert(
            title: Text("Confirm Deletion"),
            message: Text("Are you sure you want to delete this record?"),
            primaryButton: .destructive(Text("Delete")) {
                if let index = itemToDelete {
                    vm.removeItem(at: index)
                }
            },
            secondaryButton: .cancel()
        )
    }

    var historySection: some View {
        Group {
            if !vm.waterIntakeHistory.isEmpty {
                HStack {
                    Text("History")
                        .font(.largeTitle)
                    Spacer()
                }
                intakeHistory
            }
        }
    }

    var intakeHistory: some View {
        List {
            ForEach(Array(vm.waterIntakeHistory.enumerated()), id: \.element.id) { index, intakeData in
                HStack {
                    VStack(alignment: .leading) {
                        Text("Date: \(intakeData.date)")
                        Text("Amount of water: \(intakeData.amount) ml")
                    }
                    Spacer()
                    deleteButton(index: index)
                }
                .listRowBackground(Color.clear)
                .padding()
                .background(Color.accentColor)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.white, lineWidth: 2))
            }
        }
        .listStyle(PlainListStyle())
    }

    func deleteButton(index: Int) -> some View {
        Button {
            itemToDelete = index
            showAlert = true
        } label: {
            Image(systemName: "trash")
                .foregroundColor(.white)
                .font(.title)
        }
    }

    var intakeSelectionBar: some View {
        VStack {
            Text("Set your daily water intake goal")
                .font(.title3)
            HStack {
                Text("\(Int(waterIntakeGoal)) ml")
                Slider(value: $waterIntakeGoal, in: 500...5000, step: 50)
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
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.white, lineWidth: 2))
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
    }
}


#Preview {
    SettingsView()
        .environmentObject(WaterHistoryViewModel())
}
