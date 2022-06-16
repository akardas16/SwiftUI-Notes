//
//  SwiftUITest.swift
//  SecondProject
//
//  Created by Abdullah Kardas on 2.05.2022.
//

import SwiftUI
import UIKit
import SDWebImageSwiftUI

struct SwiftUITest: View {
    
    @State var textField:String = ""
    @State var scrollToIndex:Int = 0

    var body: some View {
 
        NavigationView{
       
            VStack{
                
                TextField("add your index", text: $textField).keyboardType(.numberPad).padding().background(.gray.opacity(0.3)).cornerRadius(16).padding()
                
                Button("Go to new index"){
                    withAnimation(.linear) {
                        scrollToIndex = Int(textField) ?? 0
                    
                    }
                   
                }
                ScrollView{
                    ScrollViewReader{proxy in
                        
                    
                        
                        ForEach(0..<50) { index in
                            RoundedRectangle(cornerRadius: 16).fill(.red).frame(maxWidth:.infinity).frame(height:150).shadow(color: .black, radius: 12, x: 0, y: 0).padding().overlay {
                                Text("Item number \(index)").foregroundColor(.white).bold().font(.title3)
                            }.id(index)
                        }.onChange(of: scrollToIndex) { value in
                            withAnimation(.spring()) {
                                proxy.scrollTo(value, anchor: .center)
                            }
                        }
                    }
                  
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



