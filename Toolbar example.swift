//
//  SwiftUITest.swift
//  SecondProject
//
//  Created by Abdullah Kardas on 2.05.2022.
//

import SwiftUI

struct SwiftUITest: View {
    
    @State private var showScreen:Bool = false
   
    @State var goDestn:Bool = false

    var body: some View {
        NavigationView{
            ZStack {
                
                VStack{
                    
                    ScrollView(.vertical, showsIndicators: false){
                        ForEach(0..<20) { index in
                          
                            NavigationLink(isActive: $goDestn) {
                                SecondSwiftUI()
                            } label: {
                                Button("First Screen"){
                                    showScreen.toggle()
                                    goDestn.toggle()
                                  
                                    
                                }.foregroundColor(.blue).font(.system(size: 20, weight: .bold, design: .rounded)).padding()
                            }
    
                        }
                    }
                   
                }
                
            }.navigationTitle(Text("Main Screen")).navigationBarTitleDisplayMode(.automatic).navigationBarBackButtonHidden(true).toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        
                    } label: {
                        Image(systemName: "arrow.backward").font(.title2).foregroundColor(.black)
                    }

                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "trash").font(.title3).foregroundColor(.blue)
                    }

                }
             
              
            }
        }
       
    }
}


struct SwiftUITest_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SwiftUITest()
        }
    }
}
