//
//  SwiftUITest.swift
//  SecondProject
//
//  Created by Abdullah Kardas on 2.05.2022.
//

import SwiftUI

struct SwiftUITest: View {

    @AppStorage("userName") var userName:String = "No name"
    @AppStorage("IsOnOff") var toggleStatus:Bool = true

    @State var name:String = ""
    var body: some View {
        
        NavigationView{
            ZStack{
           
                Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)).ignoresSafeArea()
                VStack{
                    Text(userName)
                    TextField("Enter name...", text: $name).padding().background(.gray.opacity(0.3)).cornerRadius(16).padding()
                    
                    Button {
                        userName = name
                    } label: {
                        Text("Save Name")
                    }
                    
                    Toggle("My Toggle", isOn: $toggleStatus).padding().tint(.yellow)
                }

        
            }.navigationBarHidden(true)
        }
    
    }

}


struct SwiftUITest_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUITest().preferredColorScheme(.light)

    }
}

