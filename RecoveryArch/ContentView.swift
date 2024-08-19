//
//  ContentView.swift
//  RecoveryArch
//
//  Created by Fernando Frances on 16/8/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ArchView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct ArchView: View {
    @State private var value: CGFloat = 50 // Example value, it can be updated dynamically

    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    // Draw the arch
                    Path { path in
                        let width = geometry.size.width
                        let height = geometry.size.height
                        path.addArc(center: CGPoint(x: width / 2, y: height),
                                    radius: width / 2,
                                    startAngle: .degrees(180),
                                    endAngle: .degrees(0),
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
        let angle = Angle(degrees: Double(180 * (value / 100)))
        let radius = size.width / 2
        let centerX = size.width / 2
        let centerY = size.height
        
        let x = centerX + radius * cos(angle.radians)
        let y = centerY - radius * sin(angle.radians)
        
        return CGPoint(x: x, y: y)
    }
}
