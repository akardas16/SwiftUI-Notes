//
//  TestPostRequest.swift
//  CombineApp
//
//  Created by Abdullah Kardas on 8.07.2022.
//

import SwiftUI
import Combine

class TestPostViewModel:ObservableObject{
    
    var cancallables = Set<AnyCancellable>()
    @Published var postmanModel:PostmanModel?
    init(){
        requestPost()
        
        
       
    }
    
    func requestPost(){
        postmanFuturePublisher(baseUrl: "https://casinoapp.casinonativeweb.xyz/api/category_info.php", parameters: [URLQueryItem(name: "pcgName", value: "com.snai.milan.italy.easy.win.scommesse.apps")])
            .map {$0}
            .decode(type: PostmanModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
            switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: {[unowned self] model in
                self.postmanModel = model
            }.store(in: &cancallables)
    }
    
    func postmanEscaping(baseUrl:String,parameters:[URLQueryItem],completionHandler: @escaping (_ data:Data,_ error:Error?) -> Void){
     
        //https://casinoapp.casinonativeweb.xyz/api/category_info.php
        guard var baseUrl = URLComponents(string: baseUrl) else {return}
        baseUrl.queryItems = parameters
        let mainUrl = baseUrl.url!
        
       var request = URLRequest(url: mainUrl)
       request.httpMethod = "POST"
      
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
         
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {return}
            print(response.debugDescription)
            completionHandler(data,error)
        }.resume()
    }
   
    func postmanFuturePublisher(baseUrl:String,parameters:[URLQueryItem]) -> Future<Data,Error>{
       Future { promise in
           self.postmanEscaping(baseUrl: baseUrl, parameters: parameters) { data, error in
               if let error = error {
                   promise(.failure(error))
               }else {
                   promise(.success(data))
               }
           }
       }
   }
}

struct TestPostRequest: View {
    @StateObject var vm = TestPostViewModel()
    var body: some View {
        VStack{
            Text(vm.postmanModel?.message ?? "")
            List{
                ForEach(vm.postmanModel?.welcomeJSON ?? [],id: \.self) { item in
                    Text(item.catName ?? "")
                }
            }
        }
    }
}

struct TestPostRequest_Previews: PreviewProvider {
    static var previews: some View {
        TestPostRequest()
    }
}
// MARK: - Welcome
struct PostmanModel: Codable,Hashable {
    static func == (lhs: PostmanModel, rhs: PostmanModel) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    let status: Bool?
    let welcomeJSON: [JSONModel]?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case status
        case welcomeJSON = "Json"
        case message
    }
}

// MARK: - JSON
struct JSONModel: Codable,Hashable {
    let catID: String?
    let appURL: String?
    let browserStatus, catName, catImg, catStatus: String?

    enum CodingKeys: String, CodingKey,Hashable {
        case catID = "catId"
        case appURL = "appUrl"
        case browserStatus, catName, catImg, catStatus
    }
}
