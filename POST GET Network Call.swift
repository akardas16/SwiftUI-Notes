//
//  CombineFuturePromise.swift
//  CombineApp
//
//  Created by Abdullah Kardas on 30.06.2022.
//

import SwiftUI
import Combine
import iPhoneNumberField
import SDWebImageSwiftUI

enum HttpMethod:String{
    case GET = "GET"
    case POST = "POST"
}

enum Endpoint{
    private static let baseUrl = "postman-echo.com"
    
    
    case Path(path:String)
    
   
    //POST
    func postRequest(value:[String: Any]) -> URLRequest?{
        guard let url = url else {return nil}
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.POST.rawValue
        request.httpBody = httpBody(value: value)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    //GET
    func getRequest() -> URLRequest?{
        guard let url = url else {return nil}
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.GET.rawValue
       // request.httpBody = httpBody
      //  request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    private var url : URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = Endpoint.baseUrl
        components.path = path
        return components.url
    }
    
    private var path: String {
        switch self {
        case .Path(let path):
            return path
            
        }
    }
    
 
    
    private func httpBody(value:[String: Any]) -> Data? {
        try? JSONSerialization.data(withJSONObject: body(value: value))
    }
   
  
    
    private func body(value:[String: Any]) -> [String:Any] {
        switch self {
        case .Path:
            return value
        }
    }
}
struct NetworkController{
    static func setEscaping(values:[String: Any],path:String,completionHandler: @escaping (_ data:Data,_ error:Error?) -> Void){
        guard let request = Endpoint.Path(path: path).postRequest(value: values) else {return}
          
         URLSession.shared.dataTask(with: request) { data, response, error in
             guard let data = data else {return}
             completionHandler(data,error)
         }.resume()
     }
    
    static func futurePublisherSET(values: [String : Any],path:String) -> Future<Data,Error>{
         Future { promise in
             self.setEscaping(values: values, path: path) { data, error in
                 if let error = error {
                     promise(.failure(error))
                 }else {
                     promise(.success(data))
                 }
             }
         }
     }
    
   static func getEscaping(path:String,completionHandler: @escaping (_ data:Data,_ error:Error?) -> Void){
        guard let request = Endpoint.Path(path: path).getRequest() else {return}
         
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {return}
            completionHandler(data,error)
        }.resume()
    }
    
   static func futurePublisherGET(path:String) -> Future<Data,Error>{
        Future { promise in
            self.getEscaping(path: path) { data, error in
                if let error = error {
                    promise(.failure(error))
                }else {
                    promise(.success(data))
                }
            }
        }
    }
    
    
    
}

class FutureViewModel:ObservableObject {
    
    var cancallables = Set<AnyCancellable>()
    @Published var dataModel:[DataModel] = []
    @Published var newDataModel:ListUserModel?
    @Published var image:Image?
    @Published var model:CustomModel?
    
    init(){
        //fetchData()

       // fetchImage()
       // fetchData2()
        
        NetworkController.futurePublisherGET(path: "/get")
            .map {$0}
            .decode(type: CustomModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print(completion)
            } receiveValue: { data in
                self.model = data
            }
            .store(in: &cancallables)

        
//        NetworkController.futurePublisherSET(values: ["name":"Abdullah","age":26], path: "/post")
//            .map{$0}
//            .decode(type: CustomModel.self, decoder: JSONDecoder())
//            .receive(on: DispatchQueue.main)
//            .sink { completion in
//                print(completion)
//            } receiveValue: { model in
//                //print(String(describing: model))
//            }.store(in: &cancallables)



        
//        getFuturePublisher()
//        .map{$0}
//        .decode(type: CustomModel.self, decoder: JSONDecoder())
//        .receive(on: DispatchQueue.main)
//        .sink{ completion in
//            switch completion {
//            case .finished:
//                print("finished")
//            case .failure(let error):
//                print(error)
//            }
//        } receiveValue: { [unowned self] model in
//
//            self.model = model
//        }.store(in: &cancallables)

        
         
      
    }
   
    func getEscapingClosure(completionHandler: @escaping (_ data:Data,_ error:Error?) -> Void){
        guard let url = URL(string: "https://postman-echo.com/get?foo1=bar1&foo2=bar2") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
         
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {return}
            completionHandler(data,error)
        }.resume()
    }
    
    func getFuturePublisher() -> Future<Data,Error>{
        Future { promise in
            self.getEscapingClosure { data, error in
                if let error = error {
                    promise(.failure(error))
                }else {
                    promise(.success(data))
                }
            }
        }
    }
    
    func fetchImage() {
        guard let url = URL(string: "https://d31ezp3r8jwmks.cloudfront.net/C3JrpZx1ggNrDXVtxNNcTz3t") else{return}
        URLSession.shared.dataTaskPublisher(for: url)
            .map {$0.data}
            .tryMap { data in
                guard let uıImage = UIImage(data: data) else {
                    throw URLError(.badServerResponse)
                }
                return Image(uiImage: uıImage)
            }
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: {[unowned self] image in
                self.image = image
            }.store(in: &cancallables)

    }
 
    func fetchData2(){
        guard let url = URL(string: "https://reqres.in/api/users?page=1") else {return}
        URLSession.shared.dataTaskPublisher(for: url)
            .map {$0.data}
            .decode(type: ListUserModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [unowned self] value in
                self.newDataModel = value
            }.store(in: &cancallables)

    }
}

struct CombineFuturePromise: View {
    @StateObject var vm = FutureViewModel()
    
    
    var body: some View {
        VStack (spacing: 16){
          
          
            Text(vm.model?.url ?? "")
            vm.image
            AnimatedImage(url: URL(string: "https://d31ezp3r8jwmks.cloudfront.net/C3JrpZx1ggNrDXVtxNNcTz3t")).resizable().indicator(SDWebImageActivityIndicator.medium)
                .transition(.flipFromLeft(duration: 1.5))
                .scaledToFit()
                .frame(width: 80, height: 80)
//            List{
//                ForEach(vm.newDataModel?.data ?? [],id: \.self) { item in
//                    Text(item.firstName).bold()
//                    Text(item.email)
//
//                }
//            }
            
           
        }
    }
}

struct CombineFuturePromise_Previews: PreviewProvider {
    static var previews: some View {
        CombineFuturePromise()
    }
}

// MARK: - DataModel
struct DataModel: Codable,Hashable {
    static func == (lhs: DataModel, rhs: DataModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    let status: Status?
    let id, user, text: String?
    let v: Int?
    let source, updatedAt, type, createdAt: String?
    let deleted, used: Bool?

    enum CodingKeys: String, CodingKey ,Hashable{
        
        case status
        case id = "_id"
        case user, text
        case v = "__v"
        case source, updatedAt, type, createdAt, deleted, used
    }
}

// MARK: - Status
struct Status: Codable ,Hashable{
    let verified: Bool?
    let sentCount: Int?
}


// MARK: - ListUserModel
struct ListUserModel: Codable,Hashable {
    static func == (lhs: ListUserModel, rhs: ListUserModel) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    let page, perPage, total, totalPages: Int?
    let data: [UserInfo]
    let support: Support?

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data, support
    }
}

// MARK: - Datum
struct UserInfo: Codable, Hashable{
    let id: Int?
    let email, firstName, lastName: String
    let avatar: String?

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}

// MARK: - Support
struct Support: Codable, Hashable{
    let url: String?
    let text: String?
}


//Get with Future Publisher

struct CustomModel: Codable {
    let args: Args?
    let headers: Headers?
    let url: String?
}

// MARK: - Args
struct Args: Codable {
}

// MARK: - Headers
struct Headers: Codable {
    let xForwardedProto, xForwardedPort, host, xAmznTraceID: String?
    let secChUa, secChUaMobile, secChUaPlatform, upgradeInsecureRequests: String?
    let userAgent, accept, secFetchSite, secFetchMode: String?
    let secFetchUser, secFetchDest, acceptEncoding, acceptLanguage: String?
    let cookie: String?

    enum CodingKeys: String, CodingKey {
        case xForwardedProto = "x-forwarded-proto"
        case xForwardedPort = "x-forwarded-port"
        case host
        case xAmznTraceID = "x-amzn-trace-id"
        case secChUa = "sec-ch-ua"
        case secChUaMobile = "sec-ch-ua-mobile"
        case secChUaPlatform = "sec-ch-ua-platform"
        case upgradeInsecureRequests = "upgrade-insecure-requests"
        case userAgent = "user-agent"
        case accept
        case secFetchSite = "sec-fetch-site"
        case secFetchMode = "sec-fetch-mode"
        case secFetchUser = "sec-fetch-user"
        case secFetchDest = "sec-fetch-dest"
        case acceptEncoding = "accept-encoding"
        case acceptLanguage = "accept-language"
        case cookie
    }
}
