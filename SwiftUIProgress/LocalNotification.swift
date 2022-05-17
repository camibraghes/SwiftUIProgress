//
//  LocalNotification.swift
//  SwiftUIProgress
//
//  Created by Camelia Braghes on 11.04.2022.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
    
    static var instance = NotificationManager()
    
    func requestAuthorization() {
        let option: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: option) { (success, error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            } else {
                print("Success")
            }
        }
    }
    
    func scheduleNotification() {
        
        //      Time notification
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 4.0, repeats: true)
        
        //        Calendar notification
        
        //        var dateComponents = DateComponents()
        //        dateComponents.hour = 20
        //        dateComponents.minute = 40
        //        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        //        Location notification
        
        //        let coordinate = CLLocationCoordinate2D(
        //            latitude: 25.00,
        //            longitude: -23.44
        //        )
        //        let region = CLCircularRegion(
        //            center: coordinate,
        //            radius: 125,
        //            identifier: UUID().uuidString
        //        )
        //        region.notifyOnEntry = true
        //        region.notifyOnExit = false
        //        let trigger = UNLocationNotificationTrigger(region: region, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = "This is my first notification"
        content.subtitle = "This was soo easy"
        content.sound = .default
        content.badge = 1
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

struct LocalNotification: View {
    var body: some View {
        VStack(spacing: 20) {
            Button("Request Permision") {
                NotificationManager.instance.requestAuthorization()
            }
            Button("Schedule Notification") {
                NotificationManager.instance.scheduleNotification()
            }
            Button("Cancel Notification") {
                NotificationManager.instance.cancelNotification()
            }
        }
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

struct LocalNotification_Previews: PreviewProvider {
    static var previews: some View {
        LocalNotification()
    }
}
