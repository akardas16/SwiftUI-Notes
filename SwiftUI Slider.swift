//
//  SwiftUITest.swift
//  SecondProject
//
//  Created by Abdullah Kardas on 2.05.2022.
//

import SwiftUI

struct SwiftUITest: View {

    @State var countStepper:Double = 5
    
    var body: some View {
        NavigationView{
            VStack {
             
            
                Text(
                    String(format: "%.0f",countStepper)).font(.title)
                Slider(value: $countStepper, in: 0...100).tint(.green).padding()
                Slider(value: $countStepper, in: 0...100, step: 1) .padding().tint(.red)

                ZStack{
                    LinearGradient(colors: [.red,.purple,.green], startPoint: .leading, endPoint: .trailing).mask {
                        Slider(value: $countStepper, in: 0...100, step: 1).padding()
                    }
                    Slider(value: $countStepper, in: 0...100, step: 1).opacity(0.05).padding()
                }.frame(height:32)
                
                ZStack{
                    LinearGradient(colors: [.red,.purple,.green], startPoint: .leading, endPoint: .trailing).mask {
                        Slider(value: $countStepper, in: 0...100, step: 1).padding()
                    }
                    Slider(value: $countStepper, in: 0...100, step: 1).tint(.clear).padding()
                }.frame(height:32)
              


                
            }.navigationBarHidden(true).navigationBarBackButtonHidden(true)
     
        }
      
    
    }
       
    }



struct SwiftUITest_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUITest()
            .preferredColorScheme(.light)
    }
}

