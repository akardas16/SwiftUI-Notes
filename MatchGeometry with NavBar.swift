//
//  AfterCombine.swift
//  SecondProject
//
//  Created by Abdullah Kardas on 22.05.2022.
//

import SwiftUI
import Combine
import SDWebImageSwiftUI
import UIKit


//View Modifiers made it easy:

struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner
    
    struct CornerRadiusShape: Shape {

        var radius = CGFloat.infinity
        var corners = UIRectCorner.allCorners

        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }

    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

extension View {
    func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}
struct navBarItems:Identifiable{
    let id:UUID = UUID()
    let name:String
    let iconName:String
}
struct AfterCombine: View {
    @State var isShown:Bool = false
    @State var selectedItem:String = "Home"
    @Namespace var nameSpace
    let items = [navBarItems(name: "Home", iconName: "house"),navBarItems(name: "Message", iconName: "message"),navBarItems(name: "Share", iconName: "arrowshape.turn.up.forward"),navBarItems(name: "Profile", iconName: "person")]
    let categories:[String] = ["Home","Search","Profile"]
  
    var body: some View {
        NavigationView{
            VStack(spacing:45){
                HStack {
                    
                    ForEach(items) { item in
                        ZStack{
                            if selectedItem == item.name {
                                Capsule()
                                    .fill(.blue.opacity(0.3))
                                    .matchedGeometryEffect(id: "firstID", in: nameSpace)
                                   
                            }
                            Text(item.name).foregroundColor(selectedItem == item.name ? Color.blue:Color.gray).font(.subheadline).frame(width:UIScreen.main.bounds.width / 4).padding(-8)
                        }.frame(maxWidth:.infinity)
                            .frame(height:50)
                            
                           
                            .onTapGesture {
                            withAnimation(.linear){
                                selectedItem = item.name
                            }
                        }
                    }
                    
                }.padding(.horizontal,24).padding(.vertical).background(Color("backgroundnav")).cornerRadius(16, corners: [.topLeft,.topRight])
               
                HStack {
                    
                    ForEach(items) { item in
                        ZStack{
                            if selectedItem == item.name {
                                Capsule()
                                    .fill(.red.opacity(0.3))
                                    .matchedGeometryEffect(id: "secondID", in: nameSpace)
                                   
                            }
                            VStack {
                                Image(systemName: selectedItem == item.name ? "\(item.iconName).fill":item.iconName)
                                    .font(.headline)
                                    .foregroundColor(selectedItem == item.name ? Color.red:Color.gray)
                                Text(item.name).foregroundColor(selectedItem == item.name ? Color.red:Color.gray).font(.subheadline)
                            }.frame(width:UIScreen.main.bounds.width / 4).padding(.vertical,4).padding(.horizontal,-16)
                        }.frame(maxWidth:.infinity)
                            .frame(height:50)
                            
                           
                            .onTapGesture {
                            withAnimation(.linear){
                                selectedItem = item.name
                            }
                        }
                    }
                    
                }.padding(.horizontal,8).padding(.vertical).background(Color("backgroundnav")).cornerRadius(16, corners: [.topLeft,.topRight])
                
                HStack {
                    
                    ForEach(items) { item in
                        VStack{
                            if selectedItem == item.name {
                                Capsule()
                                    .fill(.red)
                                    .matchedGeometryEffect(id: "thirdID", in: nameSpace).frame(height:3).frame(maxWidth:.infinity).padding(.horizontal,12)
                                   
                            }else {
                                Capsule()
                                    .fill(.red.opacity(0.0))
                                    .frame(height:3).frame(maxWidth:.infinity).padding(.horizontal,12)
                            }
                            VStack {
                                
                                Image(systemName: selectedItem == item.name ? "\(item.iconName).fill":item.iconName)
                                    .font(.headline)
                                    .foregroundColor(selectedItem == item.name ? Color.red:Color.gray)
                                Text(item.name).foregroundColor(selectedItem == item.name ? Color.red:Color.gray).font(.subheadline)
                            }.frame(width:UIScreen.main.bounds.width / 4).padding(.vertical,2).padding(.horizontal,-16)
                        }.frame(maxWidth:.infinity)
                            .frame(height:50)
                            
                           
                            .onTapGesture {
                            withAnimation(.spring()){
                                selectedItem = item.name
                            }
                        }
                    }
                    
                }.padding(.vertical).background(Color("backgroundnav")).cornerRadius(16, corners: [.topLeft,.topRight])
                
                HStack {
                    
                    ForEach(items) { item in
                        VStack{
                            VStack {
                                
                                Image(systemName: selectedItem == item.name ? "\(item.iconName).fill":item.iconName)
                                    .font(.headline)
                                    .foregroundColor(selectedItem == item.name ? Color.green:Color.gray)
                                Text(item.name).foregroundColor(selectedItem == item.name ? Color.green:Color.gray).font(.subheadline)
                            }.frame(width:UIScreen.main.bounds.width / 4).padding(.vertical,2).padding(.horizontal,-16)
                            
                            if selectedItem == item.name {
                                Capsule()
                                    .fill(.green)
                                    .matchedGeometryEffect(id: "fourthID", in: nameSpace).frame(height:3).frame(maxWidth:.infinity).padding(.horizontal,12)
                                   
                            }else {
                                Capsule()
                                    .fill(.green.opacity(0.0))
                                    .frame(height:3).frame(maxWidth:.infinity).padding(.horizontal,12)
                            }
                        }.frame(maxWidth:.infinity)
                            .frame(height:50)
                            
                           
                            .onTapGesture {
                            withAnimation(.spring()){
                                selectedItem = item.name
                            }
                        }
                    }
                    
                }.padding(.vertical).background(Color("backgroundnav")).cornerRadius(16, corners: [.topLeft,.topRight])
                

                HStack {
                    
                    ForEach(items) { item in
                        VStack{
                            VStack {
                                
                                Image(systemName: selectedItem == item.name ? "\(item.iconName).fill":item.iconName)
                                    .font(.headline)
                                    .foregroundColor(selectedItem == item.name ? Color.white:Color.gray)
                                Text(item.name).foregroundColor(selectedItem == item.name ? Color.white:Color.gray).font(.subheadline)
                            }.frame(width:UIScreen.main.bounds.width / 4).padding(.vertical,2).padding(.horizontal,-16)
                            
                            if selectedItem == item.name {
                                Circle()
                                    .fill(.white)
                                    .matchedGeometryEffect(id: "fifthID", in: nameSpace).frame(width: 6, height: 6).padding(.horizontal,12)
                                   
                            }else {
                                Circle()
                                    .fill(.white.opacity(0))
                                    .frame(width: 6, height: 6).padding(.horizontal,12)
                            }
                        }.frame(maxWidth:.infinity)
                            .frame(height:50)
                            
                           
                            .onTapGesture {
                            withAnimation(.spring()){
                                selectedItem = item.name
                            }
                        }
                    }
                    
                }.padding(.vertical).background(Color("backgroundnav")).cornerRadius(16, corners: [.topLeft,.topRight])
            }.navigationBarHidden(true).onTapGesture {
                withAnimation(.spring()){
                    isShown.toggle()
                }
            }
  
        }
    }
}

struct AfterCombine_Previews: PreviewProvider {
    static var previews: some View {
        AfterCombine()
    }
}
