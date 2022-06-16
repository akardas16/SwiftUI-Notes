//
//  SwiftUITest.swift
//  SecondProject
//
//  Created by Abdullah Kardas on 2.05.2022.
//

import SwiftUI
import UIKit
import SDWebImageSwiftUI

struct SwiftUITest: View {
    
    @State var rating:Int = 3
    var body: some View {
 
        NavigationView{
            ZStack {
             
                startsView.overlay {
                    overlayView.mask(startsView)
                }
            }.navigationBarHidden(true)
           
        }
       
  
        }
    
    
    var overlayView:some View {
        GeometryReader{geometry in
            ZStack(alignment:.leading) {
                Rectangle().fill(LinearGradient(colors: [.yellow,.green,.yellow], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: CGFloat(rating) / 5 * geometry.size.width)
            }

        }.allowsHitTesting(false)
    }
    var startsView:some View {
        HStack{

            ForEach(1..<6) { index in
                Image(systemName: "star.fill").font(.largeTitle).foregroundColor(.gray).onTapGesture {
                    withAnimation(.linear) {
                        rating = index
                    }
                }
            }
            
        }
    }
    
    
    }
    



struct SwiftUITest_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUITest().preferredColorScheme(.light)

    }
}




struct NextView: View {
    @Binding var value:String
    var body: some View {
        ZStack {
            Text(value)
        }
    }
}
