//
//  AfterCombine.swift
//  SecondProject
//
//  Created by Abdullah Kardas on 22.05.2022.
//

import SwiftUI
import Combine

struct SpecialStyle: ButtonStyle {
    let isActionWorking:Bool
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label.foregroundColor(.white).frame(maxWidth:.infinity).frame(width:isActionWorking ? 50 : .infinity).padding(.vertical,18).background(Capsule().fill(.purple)).padding(.horizontal).animation(.linear, value: isActionWorking)
            .overlay {
                if isActionWorking {
                    ProgressView().progressViewStyle(.circular).tint(.white).scaleEffect(2)
                }
                
            }
    }
}
struct myModifier:ViewModifier {
    
    let backColor:Color
    func body(content: Content) -> some View {
        content.foregroundColor(.white).font(.title).frame(maxWidth:.infinity).frame(height:24).padding().background(backColor).cornerRadius(12).padding()
    }
}
extension View {
    func modifierFormat(backColor:Color = Color.red) -> some View{
        self.modifier(myModifier(backColor: backColor))
    }
    
    func specialStyle(isActionWorking:Bool) -> some View {
        buttonStyle(SpecialStyle(isActionWorking: isActionWorking))
    }
}

struct AfterCombine: View {
    @State var isAction:Bool = false
  
   
    var body: some View {
        NavigationView{
            VStack{
                Text("hello").modifierFormat()
                Button {
                    isAction.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        isAction.toggle()
                    }
                } label: {
                    Text(isAction ? "":"Click Me").animation(.none, value: isAction)
                }.specialStyle(isActionWorking: isAction).disabled(isAction)

            }.navigationBarHidden(true)
  
        }
    }
}

struct AfterCombine_Previews: PreviewProvider {
    static var previews: some View {
        AfterCombine()
    }
}
