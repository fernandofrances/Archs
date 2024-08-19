//
//  ContentView.swift
//  RecoveryArch
//
//  Created by Fernando Frances on 16/8/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        FractionalArchView()
            .frame(height: 200)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FractionalArchView: View {
    @State private var value: CGFloat = 50 // Example value, it can be updated dynamically
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    // Draw the fractional arch
                    Path { path in
                        let width = geometry.size.width
                        let height = geometry.size.height
                        let centerX = width / 2
                        let centerY = height
                        let radius = width / 2
                        path.addArc(center: CGPoint(x: centerX, y: centerY),
                                    radius: radius,
                                    startAngle: .degrees(180 + 67.5),
                                    endAngle: .degrees(360 - 67.5),
                                    clockwise: false)
                    }
                    .stroke(Color.gray, lineWidth: 4)
                    
                    // Draw the ball
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 20, height: 20)
                        .position(self.ballPosition(in: geometry.size))
                }
            }
            .frame(height: 200)
            
            // Slider to change the value
            Slider(value: $value, in: 0...100)
                .padding()
        }
    }
    
    private func ballPosition(in size: CGSize) -> CGPoint {
        // Adjust angle calculation to match the arch segment
        let startAngle =  180 - 67.5
        let endAngle = 67.5
        let totalAngle = endAngle - startAngle
        
        let angle = Angle(degrees: startAngle + (totalAngle * Double(value / 100)))
        let radius = size.width / 2
        let centerX = size.width / 2
        let centerY = size.height
        
        // Reverse the y-axis calculation
        let x = centerX + radius * cos(angle.radians)
        let y = centerY - radius * sin(angle.radians)
        
        return CGPoint(x: x, y: y)
    }
}

