//
//  BackgroundView.swift
//  Water Tracker
//
//  Created by Pavel Markitantov on 16/01/2024.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        Group {
            Color("mainBlue")
            TrapezoidShape()
                .fill(Color("secondaryBlue"))
        }
        .ignoresSafeArea()
    }
}

#Preview {
    BackgroundView()
}
