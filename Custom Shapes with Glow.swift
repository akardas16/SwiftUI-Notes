//
//  AfterCombine.swift
//  SecondProject
//
//  Created by Abdullah Kardas on 22.05.2022.
//

import SwiftUI
import Combine
import SDWebImageSwiftUI
import UIKit


struct Triangle:Shape {
    func path(in rect: CGRect) -> Path {
        Path{path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.closeSubpath()
        }
    }
}
struct Pacman:Shape {
    var offsetAmount:Double
    
    var animatableData: Double {
        get{offsetAmount}
        set{offsetAmount = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        Path{path in
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: Angle(degrees: offsetAmount), endAngle: Angle(degrees: 360 - offsetAmount), clockwise: false)
        }
    }
}
struct Diamond:Shape {
    func path(in rect: CGRect) -> Path {
        Path {path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - rect.width * 0.2, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + rect.width * 0.2, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}

struct Pentagon:Shape {
    func path(in rect: CGRect) -> Path {
        Path{path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY)) // Point
            path.addLine(to: CGPoint(x: rect.minX, y: rect.height * 0.4))
            path.addLine(to: CGPoint(x: rect.width * 0.2, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.width * 0.8, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.height * 0.4))
            path.closeSubpath()
        }
    }
}

struct ShapeWithArc:Shape {
    func path(in rect: CGRect) -> Path {

        Path {path in
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.height * 0.25))
            //Bottom line
            path.addArc(center: CGPoint(x: rect.midX, y: rect.height * 0.25), radius: rect.width / 2, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 180), clockwise: false)
            path.closeSubpath()
        }
    }
}

struct CustomArc:Shape {
    func path(in rect: CGRect) -> Path {
        Path{path in
            path.move(to: .zero)
            path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.midY), control: CGPoint(x: rect.minX, y: rect.maxY * 2))
            path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.maxY), control: CGPoint(x: rect.maxX , y: rect.height * -1 ))
            path.closeSubpath()
        }
    }
}

struct QuadShape:Shape {
    func path(in rect: CGRect) -> Path {
        Path{path in
            path.move(to: CGPoint(x: rect.minX , y: rect.minY))
        
            path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.minY), control: CGPoint(x: rect.midX, y: rect.height))
          
            path.closeSubpath()

        }
    }
}
struct WaveArc:Shape {
    func path(in rect: CGRect) -> Path {
        Path{path in
            path.move(to: CGPoint(x: rect.minX, y: rect.height * 0.25 ))
            path.addQuadCurve(to: CGPoint(x: rect.width / 2, y: rect.height * 0.25), control: CGPoint(x: rect.width / 4, y: rect.minY))
            
            path.addQuadCurve(to: CGPoint(x: rect.width , y: rect.height * 0.25), control: CGPoint(x:  3 * rect.width / 4, y: rect.height * 0.5))
            
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to:CGPoint(x: rect.minX, y: rect.height * 0.25))
        }
    }
}

struct AfterCombine: View {
    @State var opac:CGFloat = 0.5
    var body: some View {
        NavigationView{
            VStack {
           
                Spacer(minLength: 24)
                HStack {
                    Triangle().stroke(.purple, lineWidth: 8).frame(width: 150, height: 150)
                        .glow(glowColor: .purple)
                    Diamond().fill(.cyan).frame(width: 75, height: 75)
                        .glow(glowColor: .cyan)
                    Pentagon().stroke(.yellow, lineWidth: 8).frame(width: 100, height: 100)
                        .glow(glowColor: .yellow)
                }
             Spacer(minLength: 16)
                ShapeWithArc().stroke(.orange, lineWidth: 8).frame(width: 100, height: 100)
                    .glow(glowColor: .orange)
                QuadShape().stroke(.green, lineWidth: 6).frame(maxWidth:.infinity).frame(height:150).padding()
                    .glow(glowColor: .green, opac: opac)
                
                CustomArc().stroke(.red, lineWidth: 6).frame(maxWidth:.infinity).frame(height:90).padding().shadow(color: .red, radius: 8)
                    .shadow(color: .red.opacity(0.8), radius: 16)
                    .shadow(color: .red.opacity(opac), radius: 24).animation(.linear(duration: 0.8).repeatForever(), value: opac).onAppear {
                        opac = 0.8
                    }
                Spacer()
                
                WaveArc().fill(
                    LinearGradient(colors: [.blue,.blue.opacity(0.9),.cyan], startPoint: .top, endPoint: .bottom)
                )
                    .frame(maxWidth:.infinity)
                    .frame(height:200).glow(glowColor: .blue)
                    
                    
            }.navigationBarHidden(true).ignoresSafeArea(edges: .bottom)
        }
    }
}

struct AfterCombine_Previews: PreviewProvider {
    static var previews: some View {
        AfterCombine().preferredColorScheme(.dark)
    }
}

extension View {
    func glow(glowColor:Color,opac:CGFloat) -> some View{
        var opac1 = opac
       return self.shadow(color: glowColor, radius: 8)
            .shadow(color: glowColor.opacity(0.8), radius: 16)
            .shadow(color: glowColor.opacity(opac1), radius: 24).animation(.linear(duration: 0.8).repeatForever(), value: opac1).onAppear {
                opac1 = 0.8
            }
    }
    
    func glow(glowColor:Color) -> some View{
        self.shadow(color: glowColor, radius: 8)
            .shadow(color: glowColor.opacity(0.8), radius: 16)
            .shadow(color: glowColor.opacity(0.6), radius: 24)
    }
}
