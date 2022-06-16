//
//  SwiftUITest.swift
//  SecondProject
//
//  Created by Abdullah Kardas on 2.05.2022.
//

import SwiftUI
import UIKit
import SDWebImageSwiftUI
import AVKit
import UserNotifications

struct SwiftUITest: View {
    
  
    var body: some View {
 
        NavigationView{
            VStack(spacing:16) {
             
                Button("Request Authorization"){
                    NotificationManager.instance.requestAuthorization()
                    
                }
                
                Button("Schedule Notification"){
                    NotificationManager.instance.scheduleNotification()
                    
                }
                
             
            }.navigationBarHidden(true).onAppear {
                UIApplication.shared.applicationIconBadgeNumber = 0
            }
           
        }
       
  
        }
    
    }
    
class NotificationManager{
    static let instance = NotificationManager()
    
    func requestAuthorization(){
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { isSucces, error in
            if let myError = error {
                print("error happened \(myError)")
            }else {
                print("succes")
            }
        }
    }
    
    func scheduleNotification(){
        
        let content = UNMutableNotificationContent()
        content.title = "Notif Title"
        content.subtitle = "You have new message"
        content.sound = .default
        content.badge = 1
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        
        let trigger2 = UNCalendarNotificationTrigger(dateMatching: DateComponents(hour:18,minute:20), repeats: true)
        
       
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}
class SoundManager{
    var player:AVAudioPlayer?
    static let instance = SoundManager()
    
    
    
    enum SongOptions:String {
        case tada
        case streetmusic
    }
    func playSound(option:SongOptions) -> Void {
        guard let url = Bundle.main.url(forResource: option.rawValue, withExtension: ".mp3") else {return}
        
        
        do{
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        }catch let error{
            print(error)
        }
        
        
    }
}
class HapticManager{
    static let instance = HapticManager()
    
    func vibrate(style:UIImpactFeedbackGenerator.FeedbackStyle){
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
    
    func vibrate(type:UINotificationFeedbackGenerator.FeedbackType){
        UINotificationFeedbackGenerator().notificationOccurred(type)
    }
}


struct SwiftUITest_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUITest().preferredColorScheme(.light)

    }
}



