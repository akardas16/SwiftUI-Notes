//
//  CustomAlert.swift
//  SecondProject
//
//  Created by Abdullah Kardas on 18.04.2022.
//

import SwiftUI

struct AlertContent<Content:View>:View {
    let content:Content
    var body: some View{
        content
    }
}

struct CustomAlert<Content:View>: View {
    @Binding var isShown: Bool
    let content:Content
    
    init(isShown: Binding<Bool>,@ViewBuilder content: () -> Content){
        _isShown = isShown
        self.content = content()
    }
    var body: some View {
        GeometryReader{geometry in
            ZStack(alignment:.center){
                if isShown {
                    Blur(style: .dark).ignoresSafeArea().animation(.none, value: isShown)
                    content
                    .padding()
                    .frame(width: geometry.size.width * 0.85)
                    //.background(Color(#colorLiteral(red: 0.9268686175, green: 0.9416290522, blue: 0.9456014037, alpha: 1)))
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
                    //.offset(x: isShown ? 0 : 400, y: 0)
                    
                }
                //Color.black.opacity(0.6).ignoresSafeArea()
                
               
            }.frame(maxWidth:.infinity).frame(maxHeight:.infinity)
                .animation(isShown ? .spring():.none, value: isShown)
            
        }
        

    }
    
}

struct CustomAlert_Previews: PreviewProvider {
    static var previews: some View {
      
        CustomAlert(isShown: .constant(true)) {
            VStack{
Text("Title").font(.title).foregroundColor(.white)
Text("describtion").foregroundColor(.white)
}
        }
        
    }
}
