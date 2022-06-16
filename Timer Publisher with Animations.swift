//
//  AfterCombine.swift
//  SecondProject
//
//  Created by Abdullah Kardas on 22.05.2022.
//

import SwiftUI

struct AfterCombine: View {
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    let timerAnim = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()
    @State var countText:String = "15"
    @State var count:Int = 15
    @State var date = Date()
    @State var timeRemaining:String = "04:59"
    @State var countAnim:Int = 0
    @State var tabAnim:Int = 0
    
    let futureDate = Calendar.current.date(byAdding: .minute, value: 5, to: Date())
    func updateDate(){
        let remaining = Calendar.current.dateComponents([.minute,.second], from: Date(), to: futureDate ?? Date())
        let minute = remaining.minute ?? 0
        var minuteT = "\(minute)"
       
        if minute < 10 {
            minuteT = "0\(minute)"
        }
        let second = remaining.second ?? 0
        var secondT = "\(second)"
        if second < 10 {
            secondT = "0\(second)"
        }
        timeRemaining = "\(minuteT):\(secondT)"
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                RadialGradient(gradient: Gradient(colors: [.cyan.opacity(0.8),.blue]),
                               center: .center,
                               startRadius: 5,
                               endRadius: 500).ignoresSafeArea()
          
                VStack{
                    
                    Text(date.getFormattedDate(format: "mm:ss"))
                        .font(.system(size: 60, weight: .bold, design: .rounded).monospacedDigit())
                        .foregroundColor(.white)
                        .frame(maxWidth:.infinity)
                    
                    Text(countText)
                        .font(.system(size: 60, weight: .bold, design: .rounded).monospacedDigit())
                        .foregroundColor(.white)
                        .frame(maxWidth:.infinity)
                    Text(timeRemaining)
                        .font(.system(size: 60, weight: .bold, design: .rounded).monospacedDigit())
                        .foregroundColor(.white)
                        .frame(maxWidth:.infinity)
                    
                    HStack(spacing:12){
                        Circle().foregroundColor(countAnim == 0 ? .green : .white).offset( y: countAnim == 0 ? -30:0)
                        Circle().foregroundColor(countAnim == 1 ? .green : .white).offset( y: countAnim == 1 ? -30:0)
                        Circle().foregroundColor(countAnim == 2 ? .green : .white).offset( y: countAnim == 2 ? -30:0)
                    }.frame(width:150,height: 120)
                    
                    TabView(selection: $tabAnim) {
                        RoundedRectangle(cornerRadius: 24).fill(.red).shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 8).tag(0).padding()
                        RoundedRectangle(cornerRadius: 45).fill(.green).shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 8).tag(1).padding()
                        RoundedRectangle(cornerRadius: 45).fill(.purple).shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 8).tag(2).padding()
                    }.frame(height:250).tabViewStyle(PageTabViewStyle())
                }
               
            }.navigationBarHidden(true).onReceive(timer, perform: {value in
                date = value
                if count > 1 {
                    count -= 1
                    countText = "\(count)"
                } else {
                    countText = "Finish!"
                }
                updateDate()
                withAnimation(.spring()){
                    tabAnim = tabAnim == 2 ? 0 : tabAnim + 1
                }
                
            }
            
            ).onReceive(timerAnim, perform: {value in
                withAnimation(.easeOut(duration: 0.3)){
                    countAnim = countAnim == 2 ? 0 : countAnim + 1
                }
            })
            
            
        }
    }
}

struct AfterCombine_Previews: PreviewProvider {
    static var previews: some View {
        AfterCombine()
    }
}
