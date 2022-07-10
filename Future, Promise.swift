//
//  CombineFuturePromise.swift
//  CombineApp
//
//  Created by Abdullah Kardas on 30.06.2022.
//

import SwiftUI
import Combine



class FutureViewModel:ObservableObject {
    
    @Published var title:String = "Starting Title"
    
    var cancallable = Set<AnyCancellable>()
    let url = URL(string: "https://www.google.com/")!
    
    init(){
        download()
       
    }
    
    func download(){
        //getCombinePublisher()
       // getFuturePublisher()
        doSomethingInFuture()
            .sink { _ in

        } receiveValue: {[unowned self] value in
            self.title = value
        }.store(in: &cancallable)
        
//        getEscapingClosure {value, error in
//            if let error = error {
//                self.title = error.localizedDescription
//            }else{
//                self.title = value
//            }
//        }
        
      

    }
    
    func getCombinePublisher() -> AnyPublisher<String,URLError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .timeout(1, scheduler: DispatchQueue.main)
            .map({ _ in
                return "New Value"
            })
            .eraseToAnyPublisher()
    }
    
    func getEscapingClosure(completionHandler: @escaping (_ value:String,_ error:Error?) -> Void){
        URLSession.shared.dataTask(with: url) { data, response, error in
            completionHandler("new value 2",error)
        }.resume()
    }
    
    func getFuturePublisher() -> Future<String,Error>{
        return Future { promise in
            self.getEscapingClosure { value, error in
                if let error = error {
                    promise(.failure(error))
                }else{
                    promise(.success(value))
                }
            }
        }
    }
    
    func doSomething(completion: @escaping (_ value:String) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            completion("Hello")
        })
    }
    
    func doSomethingInFuture() -> Future<String,Never> {
        Future { promise in
            self.doSomething { value in
                promise(.success(value))
            }
        }
    }
 
}

struct CombineFuturePromise: View {
    @StateObject var vm = FutureViewModel()
    var body: some View {
        VStack {
            Text(vm.title)
        }
    }
}

struct CombineFuturePromise_Previews: PreviewProvider {
    static var previews: some View {
        CombineFuturePromise()
    }
}
