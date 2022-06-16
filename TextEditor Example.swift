//
//  SwiftUITest.swift
//  SecondProject
//
//  Created by Abdullah Kardas on 2.05.2022.
//

import SwiftUI

struct SwiftUITest: View {
  
    @State var showAlert:Bool = false
    @State var text:String = "This is initial"
    var body: some View {
        NavigationView{
            VStack {
                VStack {
                   TextEditor(text: $text)
                        .frame(height:150, alignment: .center)
                     .lineSpacing(10)
                     .autocapitalization(.words)
                     .disableAutocorrection(true)
                     .padding()
                                        
                }.overlay(
                         RoundedRectangle(cornerRadius: 24)
                            .stroke(Color.blue.opacity(0.4), lineWidth: 3)
                         )
                .padding()
                
               
                Button {
                    
                } label: {
                    Label("Send", systemImage: "paperplane.fill").foregroundColor(.white).font(.system(size: 18, weight: .regular, design: .rounded))
                        .frame(maxWidth:.infinity).frame(height:50).background(.green).cornerRadius(25)
                       .padding(.horizontal,32)
                }.buttonStyle(MyButtonStyle())
            }.navigationBarHidden(true)
        }
       
    }

}

struct SwiftUITest_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUITest()
            .preferredColorScheme(.light)
    }
}

