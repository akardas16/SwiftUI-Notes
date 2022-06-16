//
//  SwiftUITest.swift
//  SecondProject
//
//  Created by Abdullah Kardas on 2.05.2022.
//

import SwiftUI

struct SwiftUITest: View {
    
    @StateObject var vm:ListViewModel = ListViewModel()
    var body: some View {
        NavigationView{
            VStack {
             
                List{
                    ForEach(vm.userArray) { user in
                        HStack{
                            Text(user.name).font(.headline).bold()
                            if user.isVerified {
                                Image(systemName: "checkmark.seal.fill").foregroundColor(.blue)
                            }
                            Spacer()
                            Text("\(user.score)").bold()
                           
                        }
                    }
                   
                }
    
             
            }.navigationBarHidden(true)
           
        }
       
  
        }
    
    }

struct UserModel:Identifiable{
    let id = UUID()
    let name:String
    let isVerified:Bool
    let score:Int
}
    

class ListViewModel:ObservableObject{
    @Published var userArray:[UserModel] = []
    
    init(){
        getUserList()
        sortByWhat(type: .sortByVerified)
        filterByWhat()
    }
    
    func getUserList(){
        self.userArray = [UserModel(name: "Abdullah", isVerified: true, score: 12),UserModel(name: "Badam", isVerified: false, score: 31),UserModel(name: "Morten", isVerified: false, score: 4),UserModel(name: "Zila", isVerified: true, score: 45),UserModel(name: "Natalia", isVerified: true, score: 89),UserModel(name: "Marry", isVerified: false, score: 27)]
    }
    
    func sortByWhat(type:SortType){
      
        if type == SortType.sortByScore{
            self.userArray.sort(by: {$0.score >= $1.score})
        }else if type == SortType.sortByAlphabetic{
            self.userArray.sort(by: {$0.name <= $1.name})
        }else if type == SortType.sortByVerified{
            self.userArray.sort(by: {$0.isVerified && !$1.isVerified})
        }
   
    }
    
    func filterByWhat(){
        self.userArray = userArray.filter({$0.isVerified})
 
    
    }
    enum SortType:String {
        case sortByScore
        case sortByAlphabetic
        case sortByVerified
    }
    
    
    
}
struct SwiftUITest_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUITest().preferredColorScheme(.light)

    }
}



