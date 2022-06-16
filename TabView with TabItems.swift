//
//  SwiftUITest.swift
//  SecondProject
//
//  Created by Abdullah Kardas on 2.05.2022.
//

import SwiftUI

struct SwiftUITest: View {

    @State var selectedTab:Int = 0
//    init() {
//        UITabBar.appearance().backgroundColor = UIColor.black.withAlphaComponent(1)
//        UITabBar.appearance().tintColor = UIColor.green
//
//    }
    var body: some View {
        
            ZStack {
             
               
            
                TabView(selection: $selectedTab) {
                    
                    TabHomeView(selectedTab: $selectedTab).tabItem {
                        Label("Home", systemImage: "house")
                    }.tag(0)
                    
                    ZStack{
                        Text("Play Page")
                    }.tabItem {
                        Label("Play", systemImage: "play.circle.fill")
                    }.tag(1)
                    
                    
                    ZStack{
                        Text("Settings Page")
                    }.tabItem {
                        Label("Settings", systemImage: "gear")
                    }.tag(2)
                }.accentColor(.purple)


                
            }.navigationBarHidden(true).navigationBarBackButtonHidden(true)
     
       
      
    
    }
       
    }



struct SwiftUITest_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUITest()
            .preferredColorScheme(.dark)
    }
}


struct TabHomeView: View {
    @Binding var selectedTab:Int
    var body: some View {
        ZStack{
            Color.purple.opacity(0.5).edgesIgnoringSafeArea(.top)
            VStack{
                Text("Home Page")
                Button {
                    selectedTab = 2
                } label: {
                    Text("Go To Profile Page").foregroundColor(.white).padding().background(.blue).cornerRadius(16)
                }
            }
           

        }
    }
}
