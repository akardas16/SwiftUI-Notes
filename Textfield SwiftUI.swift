//
//  LoginPage.swift
//  SecondProject
//
//  Created by Abdullah Kardas on 23.04.2022.
//

import SwiftUI
import FirebaseAuth
import AlertToast
import PasswordTextField

struct LoginPage: View {
   // @State var isSignIn:Bool = false
 
  
    var body: some View {
        ZStack{

           
       
            

//            if isSignIn {
//
//            }
            SignUpUI(mailTextField: "",passwordField: "",rePasswordField: "",isShowedLogin: false)
//            LoginUI(mailTextField: "", passwordField: "", isShowedLogin: .constant(false))
        }.ignoresSafeArea()
        
    }
}

struct LoginUI:View {
    @State var mailTextField:String
    @State var passwordField:String
    @FocusState private var isMailFoucussed:Bool
    @FocusState private var isPaswordFocussed:Bool
    @State private var passwordVisible:Bool = false
    
    @Binding var isShowedLogin:Bool
    @State var isShownToast:Bool = false
    @State var toastMessage:String = ""
    
    @State var showLoadingV:Bool = false

    var body: some View{
        ZStack{
            Ellipse().trim(from: 0.0, to: 0.5).fill(.red)
                .frame(width: UIScreen.main.bounds.width * 1.4, height: UIScreen.main.bounds.height * 0.35)
                           .position(x: UIScreen.main.bounds.width / 2.0, y: UIScreen.main.bounds.height * 0.00)
                           .shadow(radius: 3)
                           .edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                Text("Login").frame(maxWidth:.infinity).font(.system(size: 36, weight: .bold, design: .rounded)).foregroundColor(.white)
                Spacer()
                Spacer()
                Spacer()
                VStack(spacing:20){
                  
                    TextField("Enter Email...",text: $mailTextField).focused($isMailFoucussed).disableAutocorrection(true).padding().frame(maxWidth:.infinity).frame(height:40).background(RoundedRectangle(cornerRadius: 12).stroke(isMailFoucussed ? .green:.gray, lineWidth: 2)).padding(.horizontal,32)
                
                    HStack{
                   
                        TextField("Enter Password...",text: $passwordField).secure(!passwordVisible).padding().disableAutocorrection(true).focused($isPaswordFocussed)
                       
                        Button {
                            passwordVisible.toggle()
                    
                        } label: {
                            Image(systemName: passwordVisible ? "eye.fill": "eye.slash.fill").tint(isPaswordFocussed ? .green:.gray).padding(.trailing,12)
                        }

                    }.frame(maxWidth:.infinity).frame(height:40).background(RoundedRectangle(cornerRadius: 12).stroke(isPaswordFocussed ? .green:.gray, lineWidth: 2)).padding(.horizontal,32)
                    
                    ZStack(alignment:.trailing){
                        Button {
                            
                        } label: {
                            Text("Forgot password?").foregroundColor(.blue)
                        }
                    }
                   

               
                

                }
                Spacer()
                VStack(spacing:16){
                    Button {
                        if mailTextField == "" {
                            toastMessage = "Please fill mail field!"
                            isShownToast.toggle()
                        }else if passwordField.count <= 6 {
                            toastMessage = "Password must be at least 6 chars!"
                            isShownToast.toggle()
                        }else if !isValidEmailAddress(emailAddressString: mailTextField){
                            toastMessage = "Please enter valid mail!"
                            isShownToast.toggle()
                            
                        }else if isValidEmailAddress(emailAddressString: mailTextField) {
                            showLoadingV.toggle()
                            signInuser(email: mailTextField, password: passwordField)
                       
                        }
                   
                    } label: {
                        Text("Sign In").frame(maxWidth:.infinity).frame(height:48).background(.blue).cornerRadius(24).foregroundColor(.white).padding(.horizontal,32)
                    }.buttonStyle(MyButtonStyle())
                    
                    Button {
                   
                    } label: {
                        Label("Sign with Google", image: "gicon").frame(maxWidth:.infinity).frame(height:48).background(.gray).cornerRadius(24).foregroundColor(.white).padding(.horizontal,32)
                    }.buttonStyle(MyButtonStyle())
                    
                    Button {
        
                   
                    } label: {
                        Label("Sign with Apple", image: "whiteappleicon").frame(maxWidth:.infinity).frame(height:48).background(.black).cornerRadius(24).foregroundColor(.white).padding(.horizontal,32)
                    }.buttonStyle(MyButtonStyle())
                }
                Spacer()
                Button {
              
                    isShowedLogin.toggle()
                } label: {
                    Text("Not a member? \(Text("Sign Up").underline().bold())").foregroundColor(.blue).padding(.vertical,25)
                }

                
            }
            LoadingAlert(isShown: $showLoadingV)
        }.toast(isPresenting: $isShownToast) {
            AlertToast(displayMode: .hud, type: .regular, title: toastMessage)
        }
        
        
    }
    
    func signInuser(email:String,password:String){
        Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
            guard let user = authResult?.user, error == nil else {
                showLoadingV.toggle()
                toastMessage = error!.localizedDescription
                isShownToast.toggle()
                
                print("error happened: \(String(describing: error?.localizedDescription))")
                return}
                          print("\(user.email!) user signed****")
            showLoadingV.toggle()
            toastMessage = "\(user.email!) user signed"
            isShownToast.toggle()
        }
       
    }
    func isValidEmailAddress(emailAddressString: String) -> Bool {
      
      var returnValue = true
      let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
      
      do {
          let regex = try NSRegularExpression(pattern: emailRegEx)
          let nsString = emailAddressString as NSString
          let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
          
          if results.count == 0
          {
              returnValue = false
          }
          
      } catch let error as NSError {
          print("invalid regex: \(error.localizedDescription)")
          returnValue = false
      }
      
      return  returnValue
  }
    
}
struct SignUpUI:View {
    @State var mailTextField:String
    @State var passwordField:String
    @State var rePasswordField:String
    @FocusState private var isMailFoucussed:Bool
    @FocusState private var isPaswordFocussed:Bool
    @FocusState private var isRePaswordFocussed:Bool
    @State private var passwordVisible:Bool = false
    @State private var rePasswordVisible:Bool = false
    
    @State var isShowedLogin:Bool
    
    @State var showToast:Bool = false
    @State var toastMessage:String = ""
    @Environment(\.presentationMode) var presentation
    @State var showLoadingToast:Bool = false
    var body: some View{
        ZStack{
            Ellipse().trim(from: 0.0, to: 0.5).fill(.red)
                .frame(width: UIScreen.main.bounds.width * 1.4, height: UIScreen.main.bounds.height * 0.35)
                           .position(x: UIScreen.main.bounds.width / 2.0, y: UIScreen.main.bounds.height * 0.00)
                           .shadow(radius: 3)
                           .edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                Text("Create New Account").frame(maxWidth:.infinity).font(.system(size: 28, weight: .bold, design: .rounded)).foregroundColor(.white)
                Spacer()
                Spacer()
                
                VStack(spacing:20){
                  
                    TextField("Enter Email...",text: $mailTextField).focused($isMailFoucussed).disableAutocorrection(true).padding().frame(maxWidth:.infinity).frame(height:40).background(RoundedRectangle(cornerRadius: 12).stroke(isMailFoucussed ? .green:.gray, lineWidth: 2)).padding(.horizontal,32)
                
                    HStack{
                   
                        TextField("Enter Password...",text: $passwordField).secure(!passwordVisible).padding().disableAutocorrection(true).focused($isPaswordFocussed)
                       
                        Button {
                            passwordVisible.toggle()
                    
                        } label: {
                            Image(systemName: passwordVisible ? "eye.fill": "eye.slash.fill").tint(isPaswordFocussed ? .green:.gray).padding(.trailing,12)
                        }
                        
                        

                    }.frame(maxWidth:.infinity).frame(height:40).background(RoundedRectangle(cornerRadius: 12).stroke(isPaswordFocussed ? .green:.gray, lineWidth: 2)).padding(.horizontal,32)
                    
                    HStack{
                   
                        TextField("Verify Password...",text: $rePasswordField).secure(!rePasswordVisible).padding().disableAutocorrection(true).focused($isRePaswordFocussed)
                       
                        Button {
                            rePasswordVisible.toggle()
                    
                        } label: {
                            Image(systemName: rePasswordVisible ? "eye.fill": "eye.slash.fill").tint(isRePaswordFocussed ? .green:.gray).padding(.trailing,12)
                        }
                        
                        

                    }.frame(maxWidth:.infinity).frame(height:40).background(RoundedRectangle(cornerRadius: 12).stroke(isRePaswordFocussed ? .green:.gray, lineWidth: 2)).padding(.horizontal,32)
                

                }
                Spacer()
                VStack(spacing:16){
                    Button {
                        
                        if mailTextField == "" {
                            toastMessage = "Please fill mail field!"
                            showToast.toggle()
                        }else if passwordField.count <= 6 {
                            toastMessage = "Password must be at least 6 chars!"
                            showToast.toggle()
                        }else if !(passwordField.elementsEqual(rePasswordField)) {
                            toastMessage = "Passwords are not matches!"
                            showToast.toggle()
                        }else if !isValidEmailAddress(emailAddressString: mailTextField){
                            toastMessage = "Please enter valid mail!"
                            showToast.toggle()
                            
                        }else if passwordField.elementsEqual(rePasswordField) && isValidEmailAddress(emailAddressString: mailTextField) {
                            showLoadingToast.toggle()
                            signUpUser(mail: mailTextField, password: passwordField)
                        }
                        
                   
                    } label: {
                        Text("Sign Up").frame(maxWidth:.infinity).frame(height:48).background(.blue).cornerRadius(24).foregroundColor(.white).padding(.horizontal,32)
                    }.buttonStyle(MyButtonStyle())
                    
                    Button {
                   
                        toastMessage = "message sent"
                        showToast.toggle()
                    } label: {
                        Label("Sign with Google", image: "gicon").frame(maxWidth:.infinity).frame(height:48).background(.gray).cornerRadius(24).foregroundColor(.white).padding(.horizontal,32)
                    }.buttonStyle(MyButtonStyle())
                    
                    Button {
        
                   
                    } label: {
                        Label("Sign with Apple", image: "whiteappleicon").frame(maxWidth:.infinity).frame(height:48).background(.black).cornerRadius(24).foregroundColor(.white).padding(.horizontal,32)
                    }.buttonStyle(MyButtonStyle())
                }
                Spacer()
                Button {
                   
                    isShowedLogin.toggle()
                    
                } label: {
                    Text("Already a member? \(Text("Sign In").underline().bold())").foregroundColor(.blue).padding(.vertical,25)
                }.fullScreenCover(isPresented: $isShowedLogin) {
                    LoginUI(mailTextField: "", passwordField: "",isShowedLogin: $isShowedLogin).ignoresSafeArea()
                }



                
            }
        }.toast(isPresenting: $showToast) {
            AlertToast(displayMode: .hud, type: .regular, title: toastMessage)
        }
     
        LoadingAlert(isShown: $showLoadingToast)
    
    }
    //HERE İS YOUR FUNCTİONS
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
      
      var returnValue = true
      let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
      
      do {
          let regex = try NSRegularExpression(pattern: emailRegEx)
          let nsString = emailAddressString as NSString
          let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
          
          if results.count == 0
          {
              returnValue = false
          }
          
      } catch let error as NSError {
          print("invalid regex: \(error.localizedDescription)")
          returnValue = false
      }
      
      return  returnValue
  }
    func signUpUser(mail:String,password:String){
        Auth.auth().createUser(withEmail: mail, password: password, completion: {authResult, error in
            guard let user = authResult?.user, error == nil else {
                showLoadingToast.toggle()
                toastMessage = error!.localizedDescription
                showToast.toggle()
                
                print("error happened: \(String(describing: error?.localizedDescription))")
                return}
                          print("\(user.email!) created****")
            showLoadingToast.toggle()
            toastMessage = "\(user.email!) created"
            showToast.toggle()
        })
    }
    
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}

extension TextField {
    
    public func secure(_ secure: Bool = true) -> TextField {
        if secure {
            var secureField = self
            withUnsafeMutablePointer(to: &secureField) { pointer in
                let offset = 32
                let valuePointer = UnsafeMutableRawPointer(mutating: pointer)
                    .assumingMemoryBound(to: Bool.self)
                    .advanced(by: offset)
                valuePointer.pointee = true
            }
            return secureField
        } else {
            return self
        }
    }
}
