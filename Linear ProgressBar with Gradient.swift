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
        VStack {
          
        
            VStack(spacing: 0) {
                Text("\(Int(progress * 100)) %").frame(maxWidth: .infinity,alignment: .leading).padding(.horizontal).font(.callout).padding(.vertical,4)
                ProgressView(value: progress)
                    .progressViewStyle(GradientProgressStyle(fill: gradient, height: 6))
                .padding(.horizontal)
            }

            
            Button("change value"){
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


struct GradientProgressStyle<Background: ShapeStyle>: ProgressViewStyle {
    
    var fill: Background
    var cornerRadius: CGFloat = 4
    var height: CGFloat = 8
    var animation: Animation = .spring()
    init(fill: Background, height: CGFloat) {
        self.fill = fill
        self.cornerRadius = height / 2
        self.height = height
    }
    
    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0
        
        return VStack {
            ZStack(alignment: .topLeading) {
                GeometryReader { geo in
                    Rectangle().fill(.gray.opacity(0.5))
                        .overlay(
                            Capsule(style: .circular).fill(fill).frame(maxWidth: geo.size.width * CGFloat(fractionCompleted))
                                .animation(animation, value: fractionCompleted)
                            ,alignment: .leading)
                   
                }
            }
            .frame(height: height)
            .cornerRadius(cornerRadius)
     
           
            
          
        }
    }
}
