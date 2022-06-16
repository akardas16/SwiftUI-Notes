//
//  SwiftUITest.swift
//  SecondProject
//
//  Created by Abdullah Kardas on 2.05.2022.
//

import SwiftUI
import UIKit

struct SwiftUITest: View {

    
    
    var body: some View {
 
        NavigationView{
            VStack {
                Spacer()
                HStack{
                    Spacer()
                    FloatAction1()
                    Spacer()
                    FloatAction2()
                    Spacer()
                }
                Spacer()
                HStack{
                    Spacer()
                    FloatAction3()
                    Spacer()
                    FloatAction4()
                }.padding(.trailing,4).padding(.bottom,16)
                
                
           
            }
        
            
            }
        }
    
    }


struct SwiftUITest_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUITest().preferredColorScheme(.light)

    }
}






struct FloatAction1: View {
    @State var showFloatButton:Bool = false
    var body: some View {
        ZStack{
            
            Button {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    showFloatButton.toggle()
                }
            } label: {
                Image(systemName: "phone.fill").font(.title2).foregroundColor(.white).frame(width: 60, height: 60).background(.blue).clipShape(Circle()).shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 0)
            }.buttonStyle(MyButtonStyle()).offset(x: 0, y: showFloatButton ? -170:0).animation(.spring(response: 0.5, dampingFraction: 0.66), value: showFloatButton)
            
            Button {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    showFloatButton.toggle()
                }
                
            } label: {
                Image(systemName: "message.fill").font(.title2).foregroundColor(.white).frame(width: 60, height: 60).background(.blue).clipShape(Circle()).shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 0)
            }.buttonStyle(MyButtonStyle()).offset(x: 0, y: showFloatButton ? -90:0).animation(.spring(response: 0.5, dampingFraction: 0.66), value: showFloatButton)
            
            Button {
                showFloatButton.toggle()
            } label: {
                Image(systemName: "chevron.up").font(.title).foregroundColor(.white).frame(width: 80, height: 80).background(.red).rotationEffect(.degrees(showFloatButton ? 180: 0)).clipShape(Circle()).shadow(color: .black.opacity(0.5), radius: 12, x: 0, y: 0).animation(.easeOut, value: showFloatButton)
            }.buttonStyle(MyButtonStyle())
            
        }.navigationBarHidden(true)
    }
}
struct FloatAction2: View {
    @State var showFloatButton:Bool = false
    var body: some View {
        ZStack{
            
            Text("Call").font(.title3).bold().foregroundColor(.blue).opacity(showFloatButton ? 1:0).padding(.horizontal,16).padding(.vertical,4).cornerRadius(12).offset(x: showFloatButton ? -60 : 0, y:-170).animation(showFloatButton ? .spring().delay(0.5):.spring(), value: showFloatButton)
            Button {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    showFloatButton.toggle()
                }
            } label: {
                Image(systemName: "phone.fill").font(.title2).foregroundColor(.white).frame(width: 60, height: 60).background(.blue).clipShape(Circle()).shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 0)
            }.buttonStyle(MyButtonStyle()).offset(x: 0, y: showFloatButton ? -170:0).animation(showFloatButton ? .spring(response: 0.5, dampingFraction: 0.66):.spring(response: 0.5, dampingFraction: 0.66).delay(0.6), value: showFloatButton)
            
            
            
            Text("Mail").font(.title3).bold().foregroundColor(.blue).opacity(showFloatButton ? 1:0).padding(.horizontal,16).padding(.vertical,4).cornerRadius(12).offset(x: showFloatButton ? -60 : 0, y:-90).animation(showFloatButton ? .spring().delay(0.5):.spring(), value: showFloatButton)
            Button {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    showFloatButton.toggle()
                }
            } label: {
                Image(systemName: "envelope.fill").font(.title2).foregroundColor(.white).frame(width: 60, height: 60).background(.blue).clipShape(Circle()).shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 0)
            }.buttonStyle(MyButtonStyle()).offset(x: 0, y: showFloatButton ? -90:0).animation(showFloatButton ? .spring(response: 0.5, dampingFraction: 0.66):.spring(response: 0.5, dampingFraction: 0.66).delay(0.6), value: showFloatButton)
            
            
            
            
            
            Button {
                showFloatButton.toggle()
            } label: {
                Image(systemName: "chevron.up").font(.title).foregroundColor(.white).frame(width: 80, height: 80).background(.red).rotationEffect(.degrees(showFloatButton ? 180: 0)).clipShape(Circle()).shadow(color: .black.opacity(0.5), radius: 12, x: 0, y: 0).animation(.easeOut, value: showFloatButton)
            }.buttonStyle(MyButtonStyle())
            
        }.navigationBarHidden(true)
    }
}
struct FloatAction3: View {
    @State var showFloatButton:Bool = false
    var body: some View {
        ZStack{
            
            
            //Upper Button
            Button {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    showFloatButton.toggle()
                }
                
            } label: {
                Image(systemName: "phone.fill").font(.title2).foregroundColor(.white).frame(width: 60, height: 60).background(.blue).clipShape(Circle()).shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 0)
            }.buttonStyle(MyButtonStyle()).offset(x: 0, y: showFloatButton ? -110:0).animation(.spring(response: 0.5, dampingFraction: 0.66), value: showFloatButton)
            
            
            //Middle Button
            Button {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    showFloatButton.toggle()
                }
                
            } label: {
                Image(systemName: "message.fill").font(.title2).foregroundColor(.white).frame(width: 60, height: 60).background(.blue).clipShape(Circle()).shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 0)
            }.buttonStyle(MyButtonStyle()).offset(x: showFloatButton ? -90:0, y: showFloatButton ? -90:0).animation(.spring(response: 0.5, dampingFraction: 0.66), value: showFloatButton)
            
            
            Button {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    showFloatButton.toggle()
                }
            } label: {
                Image(systemName: "envelope.fill").font(.title2).foregroundColor(.white).frame(width: 60, height: 60).background(.blue).clipShape(Circle()).shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 0)
            }.buttonStyle(MyButtonStyle()).offset(x: showFloatButton ? -110:0, y: 0).animation(.spring(response: 0.5, dampingFraction: 0.66), value: showFloatButton)
            
            
            
           
            
            
            //Main Button
            Button {
                showFloatButton.toggle()
            } label: {
                Image(systemName: "chevron.up").font(.title).foregroundColor(.white).frame(width: 80, height: 80).background(.red).rotationEffect(.degrees(showFloatButton ? -45: 135)).clipShape(Circle()).shadow(color: .black.opacity(0.5), radius: 12, x: 0, y: 0).animation(.easeOut, value: showFloatButton)
            }.buttonStyle(MyButtonStyle())
            
        }.navigationBarHidden(true)
    }
}
struct FloatAction4: View {
    @State var showFloatButton:Bool = false
    var body: some View {
        ZStack{
            
            
            //Upper Button
            Button {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    showFloatButton.toggle()
                }
                
            } label: {
                Image(systemName: "phone.fill").font(.title2).foregroundColor(.white).frame(width: 60, height: 60).background(.blue).clipShape(Circle()).shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 0)
            }.buttonStyle(MyButtonStyle()).offset(x: 0, y: showFloatButton ? -110:0).animation(showFloatButton ? .easeOut(duration: 0.3) : .easeOut(duration: 0.3).delay(0.66), value: showFloatButton)
            
            
            //Middle Button
            Button {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    showFloatButton.toggle()
                }
                
            } label: {
                Image(systemName: "message.fill").font(.title2).foregroundColor(.white).frame(width: 60, height: 60).background(.blue).clipShape(Circle()).shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 0)
            }.buttonStyle(MyButtonStyle()).offset(x: showFloatButton ? -90:0, y: showFloatButton ? -90:0).animation(showFloatButton ? .easeOut(duration: 0.36).delay(0.3) : .easeOut(duration: 0.36).delay(0.3), value: showFloatButton)
            
            
            Button {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    showFloatButton.toggle()
                }
            } label: {
                Image(systemName: "envelope.fill").font(.title2).foregroundColor(.white).frame(width: 60, height: 60).background(.blue).clipShape(Circle()).shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 0)
            }.buttonStyle(MyButtonStyle()).offset(x: showFloatButton ? -110:0, y: 0).animation(showFloatButton ? .easeOut(duration: 0.3).delay(0.66) : .easeOut(duration: 0.3), value: showFloatButton)
            
            
            
           
            
            
            //Main Button
            Button {
                showFloatButton.toggle()
            } label: {
                Image(systemName: "chevron.up").font(.title).foregroundColor(.white).frame(width: 80, height: 80).background(.red).rotationEffect(.degrees(showFloatButton ? -45: 135)).clipShape(Circle()).shadow(color: .black.opacity(0.5), radius: 12, x: 0, y: 0).animation(.easeOut, value: showFloatButton)
            }.buttonStyle(MyButtonStyle())
            
        }.navigationBarHidden(true)
    }
}

struct MyButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? CGFloat(0.85) : 1.0)
            .animation(Animation.spring(response: 0.35, dampingFraction: 0.35, blendDuration: 1), value: configuration.isPressed)
    }
}
