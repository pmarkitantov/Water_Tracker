//
//  Water_TrackerApp.swift
//  Water Tracker
//
//  Created by Pavel Markitantov on 15/01/2024.
//

import SwiftUI

@main
struct Water_TrackerApp: App {
    
    var user = User()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .preferredColorScheme(.light)
                .statusBarHidden(true)
        }
    }
}
