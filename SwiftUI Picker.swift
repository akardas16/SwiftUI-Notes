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
    
    @State var selection:String = "Choose any vegetable"
    let itemList:[String] = ["Orange","Lemon","Banana","Apple","Strawberry"]
    let brands = ["Samsung","Apple","Hp"]
    @State var selectedBrand:String = "Apple"
    
    init(){
        UISegmentedControl.appearance().selectedSegmentTintColor = .systemBlue
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.white], for: .selected)
    }
    var body: some View {
        NavigationView{
            VStack(spacing:32) {
              
               
                Text("Selected Value: \(selection)").font(.title3).bold()
                
                //Wheel Picker Style
                Picker(selection: $selection) {
                    
                    ForEach(itemList,id:\.self) { item in
                       Text(item)
                    }
                    
                    
                } label: {
                  Text("Hello")
                    
                }.accentColor(.purple).pickerStyle(WheelPickerStyle()).frame(width:200).background(.gray.opacity(0.4)).cornerRadius(16).padding(.horizontal,45)
                
                //Default Picker Style
            
                Menu(selection) {
                        Picker("Please choose a color", selection: $selection)
                        {
                            ForEach(itemList, id: \.self) {item in
                                Text(item)
                            }
                        }
                        
                    }
                .foregroundColor(Color.white).frame(maxWidth:.infinity).padding().background(.blue).cornerRadius(16).padding()
                
                
            
                //Segmented Picker Style
                Picker(selection: $selectedBrand) {
                    
                    ForEach(brands,id:\.self) { item in
                       Text(item)
                    }
                    
                    
                } label: {
                  Text("Hello")
                    
                }.pickerStyle(SegmentedPickerStyle()).frame(maxWidth:.infinity).background(.gray.opacity(0.4)).cornerRadius(8).padding(.horizontal,4)
                
                Text(selectedBrand)
                
            }
            
          
           

                
            }.navigationBarHidden(true)
        }
       
    }



struct SwiftUITest_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUITest()
            .preferredColorScheme(.light)
    }
}

