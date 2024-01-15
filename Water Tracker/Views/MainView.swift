//
//  MainView.swift
//  Water Tracker
//
//  Created by Pavel Markitantov on 15/01/2024.
//

import SwiftUI

struct MainView: View {
    var date = Date()

    var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "dd MMMM"
        return df
    }

    @AppStorage("SelectedVolume") private var selectedVolume = 500
    @AppStorage("TotalWater") private var totalWater = 0
    @AppStorage("currentDate") private var currentDate = ""
    

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
        .onAppear {
            let dateAndMonthString = dateFormatter.string(from: self.date)
            if currentDate == "" || currentDate != dateAndMonthString {
                currentDate = dateAndMonthString
                totalWater = 0
            }
        }
    }
        
}

#Preview {
    MainView()
}
