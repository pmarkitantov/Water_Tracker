//
//  WelcomeView.swift
//  Water Tracker
//
//  Created by Pavel Markitantov on 15/01/2024.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack {
            Group {
                Color("mainBlue")
                TrapezoidShape()
                    .fill(Color("secondaryBlue"))
            }
            .ignoresSafeArea()
            
            
        }
    }
}

#Preview {
    WelcomeView()
}
