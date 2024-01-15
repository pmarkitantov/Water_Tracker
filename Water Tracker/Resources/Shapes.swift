//
//  Shapes.swift
//  Water Tracker
//
//  Created by Pavel Markitantov on 15/01/2024.
//

import Foundation
import SwiftUI

struct TrapezoidShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
                
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.midY * 1.5), control: CGPoint(x: rect.midX, y: rect.midY * 1.5))
        
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        
        path.closeSubpath()
        
        
        return path
    }
}
