//
//  Water_TrackerApp.swift
//  Water Tracker
//
//  Created by Pavel Markitantov on 15/01/2024.
//

import SwiftUI

@main
struct Water_TrackerApp: App {
    
//    @StateObject var dataManager = DataManager()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(DataManager())
                //                .preferredColorScheme(.light)
//                .statusBarHidden(true)
        }
        

    }
}
