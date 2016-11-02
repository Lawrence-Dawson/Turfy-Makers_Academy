//
//  MessageHandler.swift
//  Turfy
//
//  Created by Tam Borine on 02/11/2016.
//  Copyright © 2016 Lawrence Dawson. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation


class MessageHandler {
    //consider extracting these elsewhere
    
    let mapViewController: MapViewController
    
    init(mapViewControllerClass: MapViewController) {
        self.mapViewController = mapViewControllerClass
    }
    
    func startWatchingForMessages() {
        DBVariables.inboxRef.observe(.childAdded, with: { (snapshot) -> Void in
            let message = Message(snapshot: snapshot)
            if message.status.rawValue != "Sent" {
                DBVariables.messages.append(message)
            } else {
                message.status = Status(rawValue: "Delivered")!
                self.addNewMessage(message: message)
                DBVariables.inboxRef.child(message.id).setValue(message.toAnyObject())
            }
        })
    }
    
    func addNewMessage(message: Message) {
        add(message: message)
        mapViewController.startMonitoring(message: message)
        saveAllMessages()
    }
    
    
    func updateMessagesCount() {
        //add a logic to ensure notifications.count < 20, iOS cannot handle more than that and may stop displaying them at all
        print("Messages (\(DBVariables.messages.count))")
    }
    
    func loadAllMessages() {
        DBVariables.messages = []
        guard let savedItems = UserDefaults.standard.array(forKey: PreferencesKeys.savedItems) else { return }
        for savedItem in savedItems {
            guard let message = NSKeyedUnarchiver.unarchiveObject(with: savedItem as! Data) as? Message else { continue }
            add(message: message)
        }
    }
    
    func saveAllMessages() {
        var items: [Data] = []
        for message in DBVariables.messages {
            let item = NSKeyedArchiver.archivedData(withRootObject: message)
            items.append(item)
        }
        UserDefaults.standard.set(items, forKey: PreferencesKeys.savedItems)
    }
    
    func add(message: Message) {
        DBVariables.messages.append(message)
        updateMessagesCount()
    }
    
    func remove(message: Message) {
        if let indexInArray = DBVariables.messages.index(of: message) {
            DBVariables.messages.remove(at: indexInArray)
        }
        updateMessagesCount()
    }
}
