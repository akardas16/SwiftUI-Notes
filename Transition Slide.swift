//
//  SwiftUITest.swift
//  SecondProject
//
//  Created by Abdullah Kardas on 2.05.2022.
//

import SwiftUI

struct SwiftUITest: View {
    
    @State private var isAnimated:Bool = false
    @State var progress:Double = 0
    var body: some View {
        ZStack(alignment:.bottom) {
            VStack{
                Spacer()
                Button("Change Color"){
                    withAnimation(.easeInOut) {
                        isAnimated.toggle()
                    }
                   
                    progress = 12 + progress
                }
                Spacer()
                Spacer()
           
            }
            if isAnimated {
                Color.black.opacity(0.5)
                RoundedRectangle(cornerRadius: 16).frame(height: UIScreen.main.bounds.height/2)
                    .transition(.move(edge: .bottom)).overlay {
                        Button("Close"){
                            withAnimation(.easeInOut) {
                                isAnimated.toggle()
                            }
                        }.foregroundColor(.white)
                    }

            }else{
                Color.clear
            }
            
          
            
            
        }.ignoresSafeArea()
    }
}

struct SwiftUITest_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SwiftUITest()
        }
    }
}
