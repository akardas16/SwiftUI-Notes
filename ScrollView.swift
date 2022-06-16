//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by Abdullah Kardas on 28.04.2022.
//

import SwiftUI

struct ContentView: View {
    let modal:[fruitModal] = [fruitModal(background: .green, count: 36, type: "Bananas"),fruitModal(background: Color(#colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1)), count: 25, type: "Apples"),fruitModal(background: .purple, count: 10, type: "Strawbery"),fruitModal(background: .orange, count: 9, type: "Pear")]
    var body: some View {
        VStack{
         
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack{
                    ForEach(modal, id: \.id) { items in
                        
                        specialView(backColor: items.background, countItem: items.count, typeItem: items.type)
                    }
                }
             
            }
        
           
           
//            ForEach(0..<modal.count) { position in
//                specialView(backColor: modal[position].background, countItem: modal[position].count, typeItem: modal[position].type)
//            }
           
         
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
    
//        ContentView(backColor: .purple, countItem: 12, typeItem: "Apples")
        ContentView()
        //ContentView(backColor: .purple, countItem: 8, typeItem: "Apples")
    }
}

struct specialView:View{
    var backColor:Color = .green
    var countItem:Int = 16
    var typeItem:String = "Bananas"
    var body: some View{
        VStack(spacing:8){
          
            Text("\(countItem)").underline().font(.system(size: 36, weight: .semibold, design: .rounded)).foregroundColor(.white)
            Text(typeItem).foregroundColor(.white).bold()
        }.frame(width: 150, height: 150).background(backColor).cornerRadius(10)
    }
}

struct fruitModal{
    var id:UUID = UUID()
    var background:Color
    var count:Int
    var type:String
}


