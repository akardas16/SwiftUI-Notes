//
//  SwiftUITest.swift
//  SecondProject
//
//  Created by Abdullah Kardas on 2.05.2022.
//

import SwiftUI
import Combine

class UITestViewModel:ObservableObject{
    @Published var postModel:[PostModel] = []
    var cancellable = Set<AnyCancellable>()
    
    init(){
    
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
     
        URLSession.shared.dataTaskPublisher(for: url)
//            .subscribe(on: DispatchQueue.global(qos: .background))
           // .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            
            .sink { completion in
                switch completion {
                case .finished:
                    print("succes")
                case .failure(let error):
                    print("***error occured\(error)")
                }
            } receiveValue: {[weak self] newModel in
                DispatchQueue.main.async {
                    self?.postModel = newModel
                }
            }
            .store(in: &cancellable)

    }
    
    
    func handleOutput(output:URLSession.DataTaskPublisher.Output) throws -> Data{
        guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
   
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



