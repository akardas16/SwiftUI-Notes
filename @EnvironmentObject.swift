//
//  SwiftUITest.swift
//  SecondProject
//
//  Created by Abdullah Kardas on 2.05.2022.
//

import SwiftUI

struct SwiftUITest: View {
    @StateObject var myModel:DataViewModel = DataViewModel()
   
    @State var isPresented:Bool = false

    var body: some View {
        
        NavigationView{
            VStack{
                List{
                    if myModel.isLoading {
                        ProgressView()
                    }else {
                        ForEach(myModel.model) { item in
                            HStack{
                                Text(item.name).frame(width:60,alignment:.leading)
                                Spacer()
                                Circle().fill(item.color).frame(width: 24, height: 24)
                                Spacer()
                                Text("\(item.count)")
                            }
                        }.onDelete { indexSet in
                            myModel.deleteItem(indexSet: indexSet)
                        }
                    }
                   
                }
                
                Button("Got To another View"){
                    isPresented.toggle()
                }.fullScreenCover(isPresented: $isPresented) {
                    RandomView()
                }
            }
        }.environmentObject(myModel)
    }
    
    }



struct SwiftUITest_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUITest()
            .preferredColorScheme(.light)
    }
}

struct DateModel:Identifiable{
    let id:UUID = UUID()
    let name:String
    let color:Color
    let count:Int
}

class DataViewModel:ObservableObject{
   @Published var model:[DateModel] = []
   @Published var isLoading:Bool = false
    
    init(){
        getData()
    }
    func getData(){
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            let dataModelTest = [DateModel(name: "Banana", color: .yellow, count: 12),DateModel(name: "Apple", color: .red, count: 36),DateModel(name: "Orange", color: .orange, count: 24)]
            self.model = dataModelTest
            self.isLoading = false
        })
       
    }
    func updateList(){
        getData()
    }
    
    func deleteItem(indexSet:IndexSet){
        model.remove(atOffsets: indexSet)
    }
}




struct RandomView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var Dmodel:DataViewModel
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    ForEach(Dmodel.model){item in
                        Text(item.name)
                    }
                }
               
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Dismiss").bold()
                }

            }
        }
       
    }
}
