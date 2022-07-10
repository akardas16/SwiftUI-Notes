//
//  SwiftUIViews.swift
//  CombineApp
//
//  Created by Abdullah Kardas on 10.07.2022.
//

import SwiftUI

struct SwiftUIViews: View {
       @State private var gradient = LinearGradient(
        gradient: Gradient(colors: [.blue.opacity(0.8), .green.opacity(0.5), .red.opacity(0.7)]),
           startPoint: .topLeading,
           endPoint: .bottomTrailing
       )
    @State var progress:Double = 0.6
   
    var body: some View {
        VStack(spacing: 45){
            ZStack {
                CircularProgressView(progress: progress,color: .green)
                    .frame(width: 120, height: 120)
                Text("\(Int(progress * 100)) %").font(.system(size: 20, weight: .semibold, design: .rounded))
            }
            Button("Change Value"){
                progress = Double.random(in: 0...1)
            }
        }
    }
}

struct SwiftUIViews_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIViews()
    }
}

struct CircularProgressView: View {
    let progress: Double
    let color:Color
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    color.opacity(0.2),
                    lineWidth: 8
                )
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    color,
                    style: StrokeStyle(
                        lineWidth: 8,
                        lineCap: .butt
                    )
                )
                .rotationEffect(.degrees(-90))
                // 1
                .animation(.spring(), value: progress)

        }
    }
}

