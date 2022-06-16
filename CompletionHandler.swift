  func downloadData(completionHandler: @escaping completion){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completionHandler(UserModel(name: "Someone", isVerified: true, score: 32))
        }
    }
    typealias completion = (_ newModel:UserModel) -> Void
    