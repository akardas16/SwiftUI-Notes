//
//  SwiftUITest.swift
//  SecondProject
//
//  Created by Abdullah Kardas on 2.05.2022.
//

import SwiftUI

struct SwiftUITest: View {
  
    @State var showAlert:Bool = false
    var body: some View {
        NavigationView{
            VStack {
                
               

                Button {
                    showAlert.toggle()
                } label: {
                    Text("Show Toast")
                }.alert(Text("Error"), isPresented: $showAlert) {
                    
                    Button(role: .cancel) {
                        
                    } label: {
                        Text("Cancel")
                    }
                    
                    Button(role: .destructive) {
                        
                    } label: {
                        Text("Finish")
                    }

                } message: {
                
                    Text("Unable to find location")
                }


                
            }
        }
       
    }

}

struct SwiftUITest_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUITest()
            .preferredColorScheme(.light)
    }
}

