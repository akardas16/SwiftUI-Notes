//
//  SwiftUITest.swift
//  SecondProject
//
//  Created by Abdullah Kardas on 2.05.2022.
//

import SwiftUI

struct SwiftUITest: View {

    @State var selectedTab:Int = 0
    @State var scale: CGFloat = 1

    var body: some View {
        
            ZStack {
             
                Color.black.opacity(0.5).ignoresSafeArea()
            
                TabView {
                    
                    RoundedRectangle(cornerRadius: 20).fill(RadialGradient(colors: [.blue.opacity(0.4),.blue.opacity(0.6),.blue], center: .center, startRadius: 12, endRadius: 300)).frame(height:300).overlay {
                        VStack{
                            Image(systemName: "heart.fill").resizable().scaledToFit().scaleEffect(scale)
                                .padding(45).foregroundColor(.red).shadow(color: .white, radius: 16, x: 0, y: 0).onAppear {
                

                                withAnimation(Animation.easeInOut(duration: 1).repeatForever()) {
                                    scale = 0.8
                                }
                            }
                        }
                    }
                    
                    RoundedRectangle(cornerRadius: 20).fill(RadialGradient(colors: [.green.opacity(0.4),.green.opacity(0.6),.green], center: .center, startRadius: 12, endRadius: 300)).frame(height:300).overlay {
                        VStack{
                            Image(systemName: "play.circle").resizable().scaledToFit().padding(45).foregroundColor(.red).shadow(color: .white, radius: 16, x: 0, y: 0)
                        }
                    }
                    
                    RoundedRectangle(cornerRadius: 20).fill(RadialGradient(colors: [.blue.opacity(0.4),.blue.opacity(0.6),.blue], center: .center, startRadius: 12, endRadius: 300)).frame(height:300).overlay {
                        VStack{
                            Image(systemName: "heart.fill").resizable().scaledToFit().padding(45).foregroundColor(.red).shadow(color: .white, radius: 16, x: 0, y: 0)
                        }
                    }
                  
                }.tabViewStyle(.page(indexDisplayMode: .always)).frame(height:300)


                
            }.navigationBarHidden(true).navigationBarBackButtonHidden(true)
     
       
      
    
    }
       
    }



struct SwiftUITest_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUITest()
            .preferredColorScheme(.light)
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
