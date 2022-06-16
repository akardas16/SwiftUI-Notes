//
//  SwiftUITest.swift
//  SecondProject
//
//  Created by Abdullah Kardas on 2.05.2022.
//

import SwiftUI

struct SwiftUITest: View {
  
    @State var backColor:Color = .purple
    
    var body: some View {
        NavigationView{
            ZStack {
                backColor.ignoresSafeArea()
                RoundedRectangle(cornerRadius: 16).fill(.black).frame(height:100).overlay {
                    ColorPicker("Color Picker", selection: $backColor, supportsOpacity: true).padding().foregroundColor(.white)
                }.padding()
               
             
                
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

