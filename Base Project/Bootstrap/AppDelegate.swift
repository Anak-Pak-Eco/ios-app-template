//
//  AppDelegate.swift
//  Base Project
//
//  Created by Naufal Fawwaz Andriawan on 29/09/23.
//

//import UIKit
//import FirebaseCore
//import FirebaseMessaging
//
//@main
//class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
//
//    func application(
//        _ application: UIApplication,
//        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//    ) -> Bool {
//        FirebaseApp.configure()
//        return true
//    }
//
//    func application(
//        _ application: UIApplication,
//        configurationForConnecting connectingSceneSession: UISceneSession,
//        options: UIScene.ConnectionOptions
//    ) -> UISceneConfiguration {
//        return UISceneConfiguration(
//            name: "Default Configuration",
//            sessionRole: connectingSceneSession.role
//        )
//    }
//
//    func application(
//        _ application: UIApplication,
//        didDiscardSceneSessions sceneSessions: Set<UISceneSession>
//    ) {
//
//    }
//
//    func application(
//        _ application: UIApplication,
//        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
//    ) {
//        UNUserNotificationCenter.current().delegate = self
//        application.registerForRemoteNotifications()
//    }
//
//    func userNotificationCenter(
//        _ center: UNUserNotificationCenter,
//        willPresent notification: UNNotification
//    ) async -> UNNotificationPresentationOptions {
//        let userInfo = notification.request.content.userInfo
//        print(userInfo)
//        return [[.sound, .badge, .banner]]
//    }
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
//        print(response.notification.request.content)
//    }
//}




import UIKit
import FirebaseCore
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let gcmMessageIDKey = "gcm.Message_ID"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        // Push Notification
        
        UNUserNotificationCenter.current().delegate = self

        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
          options: authOptions,
          completionHandler: { _, _ in }
        )

        application.registerForRemoteNotifications()
        
        // Messaging Delegate
        
        Messaging.messaging().delegate = self

        
        return true
    }

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification) async
    -> UNNotificationPresentationOptions {
    let userInfo = notification.request.content.userInfo

    // Print full message.
    print(userInfo)

    // Change this to your preferred presentation option
    return [[.alert, .sound]]
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse) async {
    let userInfo = response.notification.request.content.userInfo

    // Print full message.
    print(userInfo)
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any]) async
      -> UIBackgroundFetchResult {

      // Print message ID.
      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }

      // Print full message.
      print(userInfo)

      return UIBackgroundFetchResult.newData
    }

    
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")

      let dataDict: [String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict
      )
    }

}

