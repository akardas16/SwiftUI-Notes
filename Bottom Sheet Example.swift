//
//  ModalSheet.swift
//  SecondProject
//
//  Created by Abdullah Kardas on 18.04.2022.
//

import SwiftUI

struct ModalSheet: View {
    @Binding var isShowing:Bool
    var backgroundMaterial:Material
    @State var curHeight:CGFloat = 400
    @State var isDragging: Bool = false
    
    var minHeight:CGFloat = 390
    var maxHeight:CGFloat = 410
    
    let startOpacity:Double = 0.6
    let endOpacity:Double = 0.7
    
    var dragPercentage:Double {
        let res = Double((curHeight - minHeight) / (maxHeight - minHeight))
        return max(0, min(1, res))
    }
    var body: some View {
       
        ZStack(alignment: .bottom){
            if isShowing {
                Color.black.opacity(startOpacity + (endOpacity - startOpacity) * dragPercentage).ignoresSafeArea().onTapGesture {
                    isShowing = false
                }
                
                mainView.transition(.move(edge: .bottom))
            }
        }.frame(maxWidth:.infinity,maxHeight: .infinity,alignment: .center).ignoresSafeArea().animation(.easeInOut, value: isShowing)
    }
    
    var mainView: some View {
        VStack{
            Capsule().frame(width: 60, height: 6, alignment: .center).foregroundColor(.white.opacity(0.7)).padding(.vertical,12)
            ZStack{
                Button {
                    isShowing.toggle()
                } label: {
                    Image(systemName: "xmark").foregroundColor(.white.opacity(0.7))
                }

            }.frame(maxWidth:.infinity,alignment: .trailing).padding(.horizontal)
            
            VStack{
                
                Text("Hello").foregroundColor(.white)
            }.frame(maxHeight:.infinity).frame(maxWidth:.infinity)
            
        }.frame(height:curHeight).frame(maxWidth:.infinity)
            .background(backgroundMaterial).cornerRadius(16)
        .animation(isDragging ? nil : .easeInOut(duration: 0.45),value: isShowing).onDisappear {
                curHeight = minHeight
            }.gesture(dragGesture)
    }
    
    @State private var prevDragTranslation = CGSize.zero
    var dragGesture: some Gesture{
        DragGesture(minimumDistance: 0, coordinateSpace: .global).onChanged { val in
            if !isDragging {
                isDragging = true
            }
            let dragAmount = val.translation.height - prevDragTranslation.height
            
            if curHeight > maxHeight || curHeight < minHeight {
                curHeight -= dragAmount / 6
            }else {
                curHeight -= dragAmount
            }
            prevDragTranslation = val.translation
        }.onEnded { val in
            prevDragTranslation = .zero
        
            isDragging = false
            if curHeight > maxHeight {
                curHeight = maxHeight
            }else if curHeight < minHeight {
                curHeight = minHeight
            }
        }
    }
}

struct ModalSheet_Previews: PreviewProvider {
    static var previews: some View {
        ModalSheet(isShowing: .constant(true), backgroundMaterial: .thinMaterial)
    }
}
