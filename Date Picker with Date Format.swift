//
//  SwiftUITest.swift
//  SecondProject
//
//  Created by Abdullah Kardas on 2.05.2022.
//

import SwiftUI

struct SwiftUITest: View {
  
    let nowDate = Date()
    @State var textDate:String = ""
    @State var selectedDate:Date = Date()
 
    var startedDate = Date()
   // var endingDate = Calendar.current.date(from: DateComponents(year:2025))!
    var endingDate = Calendar.current.date(byAdding: .year, value: 10, to: Date())

    
    var body: some View {
        NavigationView{
            VStack {
             
                Text(selectedDate.getFormattedDate(style: .medium))
                
                DatePicker("Select a date", selection: $selectedDate, in: startedDate...endingDate!, displayedComponents: [.date,.hourAndMinute]).datePickerStyle(.compact).padding()
               
               
             
                
            }.navigationBarHidden(true).navigationBarBackButtonHidden(true)
     
        }
      
    
    }
       
    }



struct SwiftUITest_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUITest()
            .preferredColorScheme(.light)
    }
}

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
    
    func getFormattedDate(style: DateFormatter.Style) -> String {
         let dateformat = DateFormatter()
         dateformat.dateStyle = style
         return dateformat.string(from: self)
     }
}