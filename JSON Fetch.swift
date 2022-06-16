//
//  SwiftUITest.swift
//  SecondProject
//
//  Created by Abdullah Kardas on 2.05.2022.
//

import SwiftUI

class UITestViewModel:ObservableObject{
    @Published var postModel:[PostModel] = []
    
    init(){
    
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        downloadData(fromUrl: url) { data in
            guard let data = data else {return}
            guard let newModel = try? JSONDecoder().decode([PostModel].self, from: data) else {return}
            DispatchQueue.main.async {[weak self] in
                self?.postModel = newModel
                print(self?.postModel)
            }
            
        }
    }
    
    
    func downloadData(fromUrl url:URL, completionHandler: @escaping downloadResult){
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil,  let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                print("error happened ")
                completionHandler(nil)
                return}
            
            completionHandler(data)
        }.resume()
    }

    typealias downloadResult = (_ data:Data?) -> Void
   
}
struct PostModel:Identifiable,Codable{
    let userId, id: Int
    let title, body: String
}


struct SwiftUITest: View {
    @StateObject var vm:UITestViewModel = UITestViewModel()
    var body: some View {
        NavigationView{
            VStack {
                List{
                    ForEach(vm.postModel) { item in
                        VStack(alignment:.leading){
                            HStack {
                                Text("\(item.id))").font(.title2).bold()
                                Text(item.title).font(.title3).bold()
                            }
                           
                            Text(item.body).foregroundColor(.gray)
                        }
                       
                    }

                }.listStyle(PlainListStyle())
               
             
            }.navigationBarHidden(true)
           
        }

        }
    
    }



struct SwiftUITest_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUITest().preferredColorScheme(.light)

    }
}



