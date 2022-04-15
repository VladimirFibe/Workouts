//
//  Notifications.swift
//  Workouts
//
//  Created by Vladimir Fibe on 14.04.2022.
//

import Foundation
import UserNotifications
import UIKit

class Notifications: NSObject {
  let notificationCenter = UNUserNotificationCenter.current()
  
  func requesAutorization() {
    notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
      guard granted else { return }
      self.getNotificationSettings()
    }
  }
  
  func getNotificationSettings() {
    notificationCenter.getNotificationSettings { settings in
    }
  }
  
  func scheduleDateNotifications(date: Date, id: String) {
    let content = UNMutableNotificationContent()
    content.title = "Workout"
    content.body = "Today you have training"
    content.sound = .default
    content.badge = 1
    
    var triggerDate = Calendar.current.dateComponents([.year, .month, .day], from: date)
    triggerDate.hour = 18
    triggerDate.minute = 12
    let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
    let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
    notificationCenter.add(request) { error in
      if let error = error {
        print(error.localizedDescription)
      }
    }
  }
}

extension Notifications: UNUserNotificationCenterDelegate {
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.alert, .sound])
  }
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    UIApplication.shared.applicationIconBadgeNumber = 0
    notificationCenter.removeAllDeliveredNotifications()
  }
}
