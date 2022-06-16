//
//  SwiftUITest.swift
//  SecondProject
//
//  Created by Abdullah Kardas on 2.05.2022.
//

import SwiftUI

struct SwiftUITest: View {
  
    @State var changeToggle:Bool = false
    @State var text:String = "This is initial"
    var body: some View {
        NavigationView{
            VStack(spacing:32) {
              
                Toggle("Change Theme", isOn: $changeToggle).tint(.purple).padding(.horizontal,12)
                
                Toggle(isOn: $changeToggle) {
                    Label("Dark Mode", systemImage: "moon.fill")
                }.tint(.green).padding(.horizontal,12)
               
                Button {
                    changeToggle.toggle()
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

