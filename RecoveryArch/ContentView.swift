//
//  ContentView.swift
//  RecoveryArch
//
//  Created by Fernando Frances on 16/8/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Color.clear.frame(maxHeight: .infinity)
            FractionalArchView(value: 0, range: 0...100)
                .background(.blue.opacity(0.5))
                .frame(height: 100)
            Color.clear.frame(maxHeight: .infinity)
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FractionalArchView: View {
    @State private var value: CGFloat
    let range: ClosedRange<CGFloat>
    
    init(value: CGFloat, range: ClosedRange<CGFloat>) {
        self.range = range
        self.value = Self.normalize(value: value, min: range.lowerBound, max: range.upperBound)
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    Arch(startAngle: .degrees(180 + 67.5), endAngle: .degrees(180 + 67.5 + 7))
                        .stroke(
                            Color.hex(0xFF9500), style: .init(lineWidth: 5, lineCap: .round)
                        )
                    
                    Arch(startAngle: .degrees(180 + 67.5 + 7), endAngle: .degrees(180 + 67.5 + 14.5))
                        .stroke(
                            Color.hex(0xFF9500),
                            style: .init(lineWidth: 5))
                    
                    Arch(
                        startAngle: .degrees(180 + 67.5 + 15),
                        endAngle: .degrees(180 + 67.5 + 15 + 15)
                    )
                    .stroke(Color.hex(0x00E35F), style: .init(lineWidth: 5))
                    
                    Arch(
                        startAngle: .degrees(180 + 67.5 + 15 + 15.5),
                        endAngle: .degrees(180 + 67.5 + 15 + 15 + 8)
                    )
                    .stroke(Color.hex(0x009C41), style: .init(lineWidth: 5))
                   
                    Arch(
                        startAngle: .degrees(180 + 67.5 + 15 + 15.5 + 7), endAngle: .degrees(180 + 67.5 + 15 + 15 + 15)
                    )
                    .stroke(
                        Color.hex(0x009C41),
                        style: .init(lineWidth: 5, lineCap: .round))
                    
                    Circle()
                        .fill(Color.white)
                        .overlay(
                            Circle().stroke(lineWidth: 1).foregroundStyle(Color.black)
                        )
                        .frame(width: 12, height: 12)
                        .position(self.ballPosition(in: geometry.size))
                    
                }
            }
            
            Slider(value: $value, in: range) {
                Text("Value")
            }
        }
    }
    
    private func ballPosition(in size: CGSize) -> CGPoint {
        let startAngle =  180 - 67.5
        let endAngle = 67.5
        let totalAngle = endAngle - startAngle
        
        let angle = Angle(degrees: startAngle + (totalAngle * value / 100))
        let radius = size.width / 2
        let centerX = size.width / 2
        let centerY = size.height
        
        let x = centerX + radius * cos(angle.radians)
        let y = centerY - radius * sin(angle.radians)
        
        return CGPoint(x: x, y: y)
    }
    
    static private func normalize(value: CGFloat, min: CGFloat, max: CGFloat) -> CGFloat {
        return (value - min) / (max - min) * 100
    }
}

struct Arch: Shape {
    
    let startAngle: Angle
    let endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        let centerX = width / 2
        let centerY = height
        let radius = width / 2
        return Path { path in
            path.addArc(center: CGPoint(x: centerX, y: centerY),
                        radius: radius,
                        startAngle: startAngle, //.degrees(180 + 67.5),
                        endAngle: endAngle, //.degrees(180 + 67.5 + 7),
                        clockwise: false)
        }
    }
}



extension Color {
    public static func hex(
        _ hex: UInt,
        opacity: Double = 1
    ) -> Self {
        Self(
            red: Double((hex & 0xff0000) >> 16) / 255,
            green: Double((hex & 0x00ff00) >> 8) / 255,
            blue: Double(hex & 0x0000ff) / 255,
            opacity: opacity
        )
    }
}
