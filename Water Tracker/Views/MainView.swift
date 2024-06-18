//
//  MainView.swift
//  Water Tracker
//
//  Created by Pavel Markitantov on 15/01/2024.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var vm: WaterHistoryViewModel
    @State private var showSettings: Bool = false
    @Environment(\.scenePhase)  var scenePhase
    var percentageCompleted: Double {
        (Double(vm.totalWater) / vm.waterIntakeGoal) * 100
    }

    var body: some View {
        ZStack {
            BackgroundView()
                
            VStack {
                headerView
                
                if vm.totalWater > 0 {
                    waterIntakeDashboard
                } else {
                    Spacer()
                }
                
                waterVolumeStepper
                addWaterButton
            }
            .frame(maxHeight: .infinity)
            .onChange(of: scenePhase) {
                vm.resetTotalCountIfNewDay()
                print("onChange trigered")
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
                .environmentObject(self.vm)
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
                vm.totalWater = 0
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
            Text("\(vm.totalWater)/\(Int(vm.waterIntakeGoal))" + "ml")
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .fontDesign(.rounded)
                .font(.largeTitle)
                .padding()
            Spacer()
            CircularProgressBar(totalWater: vm.totalWater, waterIntakeGoal: vm.waterIntakeGoal, percentageCompleted: percentageCompleted)
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
    
    var waterVolumeStepper: some View {
        Group {
            Text("Select your hydration volume")
                .foregroundStyle(.white)
                .padding(5)
            HStack {
                Button {
                    vm.selectedVolume -= 50
                    if vm.selectedVolume < 0 {
                        vm.selectedVolume = 0
                    }
                } label: {
                    Image(systemName: "minus.circle")
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .font(.title)
                }
                
                Text(String(vm.selectedVolume) + "ml")
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .font(.largeTitle)
                
                Button {
                    vm.selectedVolume += 50
                    
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
    
    var addWaterButton: some View {
        Group {
            Button {
                vm.totalWater += vm.selectedVolume
                
            } label: {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 100))
                    .foregroundColor(.white)
            }
            .padding(15)
            Text("Click to add the amount of water")
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    MainView()
        .environmentObject(WaterHistoryViewModel())
}
