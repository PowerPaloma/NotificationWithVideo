//
//  ViewController.swift
//  NotificationWithVideo
//
//  Created by Paloma Bispo on 08/10/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit
import UserNotifications
class ViewController: UIViewController {
    


    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().delegate = self
        
        handleNotification()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func handleNotification(){
        let content = UNMutableNotificationContent()
        content.title = "This is a video"
        content.body = "Wow!"
        content.sound = UNNotificationSound.default
        
        if let url = Bundle.main.url(forResource: "movie",
                                     withExtension: "mp4") {

            if let attachment = try? UNNotificationAttachment(identifier:
                UUID().uuidString, url: url, options: nil) {
                content.attachments = [attachment]
            }
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        
        
        UNUserNotificationCenter.current().add(request) { (error) in
            print(error?.localizedDescription)
        }

    }

}

extension ViewController: UNUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound, .badge])
    }
}
