//
//  SwiftUITest.swift
//  SecondProject
//
//  Created by Abdullah Kardas on 2.05.2022.
//

import SwiftUI

struct SwiftUITest: View {
    @State var fruits:[String] = ["Apple","Orange","Banana","Lemon","Strawberry","Watermelon"]

    var body: some View {
        NavigationView{
            ZStack {
                
               

                List{
                    Section {
                  
                        ForEach(fruits, id: \.self) { item in
                            Text(item.capitalized)
                        }.onDelete { indexSet in
                            fruits.remove(atOffsets: indexSet)
                        }.onMove { indices, newIndex in
                            fruits.move(fromOffsets: indices, toOffset: newIndex)
                        }
                    } header: {
                        Text("Fruits")
                    }
                  


                }.listStyle(DefaultListStyle())
          
                
            }.toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Item"){
                        fruits.append("Cherry")
                        fruits.append("Coconout")
                    }
                }
            }
        }.tint(.red)
       
    }
}


struct SwiftUITest_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUITest()
            .preferredColorScheme(.light)
    }
}

