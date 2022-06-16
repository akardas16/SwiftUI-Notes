//
//  SwiftUITest.swift
//  SecondProject
//
//  Created by Abdullah Kardas on 2.05.2022.
//

import SwiftUI

struct SwiftUITest: View {


    @State var myList:[String] = ["Banana","Apple","Orange","Lemon"]
    var body: some View {
        
      
        NavigationView{
            VStack{
          
                List{
                    ForEach(myList, id: \.self) { item in
                        Text(item).font(.headline).swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button("Archive"){
                                
                            }.tint(.green)
                            
                            Button("Delete"){
                                
                            }.tint(.red)
                            
                            Button("Mark"){
                                
                            }.tint(.yellow)
                        }.swipeActions(edge: .leading, allowsFullSwipe: true) {
                            Button("Hide"){
                                
                            }.tint(.pink)
                            
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

