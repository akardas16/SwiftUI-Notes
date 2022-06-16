//
//  SwiftUITest.swift
//  SecondProject
//
//  Created by Abdullah Kardas on 2.05.2022.
//

import SwiftUI

struct SwiftUITest: View {


    var body: some View {
        
        let url = URL(string: "https://cdn.pixabay.com/photo/2015/07/09/22/45/tree-838667__480.jpg")
        NavigationView{
            VStack{
                //AsyncImage Example 1
                AsyncImage(url: url) { image in
                    image.resizable().scaledToFit().cornerRadius(24).frame(width: 200, height: 200)
                } placeholder: {
                    ProgressView()
                }
                
                //AsyncImage Example 2
                AsyncImage(url: url,transaction: Transaction(animation: .easeOut)) { phase in
                    switch phase {
                    case .success(let image):
                        image.resizable().scaledToFit().cornerRadius(24).frame(width: 200, height: 200)
                    default:
                        ProgressView()
                    }
                }
                
                //AsyncImage Example 3
                AsyncImage(url: url,transaction: Transaction(animation: .easeOut)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable().scaledToFit().cornerRadius(24).frame(width: 200, height: 200)
                    case .failure(_):
                        Image(systemName: "questionmark.circle").resizable().scaledToFit().cornerRadius(24).frame(width: 200, height: 200)

                    default:
                        Image(systemName: "questionmark.circle").resizable().scaledToFit().cornerRadius(24).frame(width: 300, height: 300)

                    }
                }

         
            }.navigationBarHidden(true)

        
            }
        }
    
    }




struct SwiftUITest_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUITest().preferredColorScheme(.light)

    }
}

