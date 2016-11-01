//
//  AppDelegate.swift
//  Turfy
//
//  Created by Lawrence Dawson on 25/10/2016.
//  Copyright © 2016 Lawrence Dawson. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	
	var window: UIWindow?
    let locationManager = CLLocationManager()
    var messages : [Message] = []
    
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
        // Override point for customization after application launch.
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil))
        UIApplication.shared.cancelAllLocalNotifications()
		// consider reactivating the line below with removing of init() function below.
        // FIRApp.configure()
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
		return true
	}

	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        FBSDKAppEvents.activateApp()
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}
    
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey: Any] = [:]) -> Bool {
        
        let handled = FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!, annotation: options[UIApplicationOpenURLOptionsKey.annotation] )
        return handled
    }
    
    override init() {
        super.init()
        // Firebase Init overwrites the default init function calling on super and then adding FIRApp config required to connect to the DB
        FIRApp.configure()
        
    }
    
    //Event handlers for notifications
    
    func handleEvent(forRegion region: CLRegion!) {
        if checkNotificationStatus(fromRegionIdentifier: region.identifier)! {
            // Show an alert if application is active
            if UIApplication.shared.applicationState == .active {
                guard let message = note(fromRegionIdentifier: region.identifier) else { return }
                window?.rootViewController?.showAlert(withTitle: nil, message: message)
                print("AN ALERT SHOULD BE DISPLAYED NOW")
            } else {
                // Otherwise present a local notification
                let notification = UILocalNotification()
                notification.alertBody = note(fromRegionIdentifier: region.identifier)
                notification.soundName = "Default"
                UIApplication.shared.presentLocalNotificationNow(notification)
            }
        } else {
            print("Notification for this message was already displayed")
            locationManager.stopMonitoring(for: region)
        }
    }
    
    func note(fromRegionIdentifier identifier: String) -> String? {
        let savedItems = UserDefaults.standard.array(forKey: PreferencesKeys.savedItems) as? [NSData]
        let messages = savedItems?.map { NSKeyedUnarchiver.unarchiveObject(with: $0 as Data) as? Message }
        let index = messages?.index { $0?.id == identifier }
        
        let messageBody: String = (index != nil ? messages?[index!]?.text : nil)!
        let messageSender: String = (index != nil ? messages?[index!]?.sender : nil)!
        return "\(messageSender): \(messageBody)"
    }
    
    func checkNotificationStatus(fromRegionIdentifier identifier: String) -> Bool? {
        let savedItems = UserDefaults.standard.array(forKey: PreferencesKeys.savedItems) as? [NSData]
        let messages = savedItems?.map { NSKeyedUnarchiver.unarchiveObject(with: $0 as Data) as? Message }
        let index = messages?.index { $0?.id == identifier }
        
        let messageID: String = (index != nil ? messages?[index!]?.id : nil)!
        let messageStatus: String = (index != nil ? messages?[index!]?.status.rawValue : nil)!
        
        if messageStatus == "Processed" {
            let inboxRef = FIRDatabase.database().reference().child("messages").child((FIRAuth.auth()?.currentUser?.uid)!)
            inboxRef.child(messageID).updateChildValues(["Status": "Notified"])
            return true
        } else {
            return false
        }

    }
    
 

}

//extending CLLocationManagerDelegate with functions responding to user did enter a region and exit a region(this one may not be needed actually, let's see if that's the case anyway. 

extension AppDelegate: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if region is CLCircularRegion {
        handleEvent(forRegion: region)
        }
    }
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if region is CLCircularRegion {
        handleEvent(forRegion: region)
        }
    }
}

