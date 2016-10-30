//
//  messageFunctionality.swift
//  Turfy
//
//  Created by Lawrence Dawson on 30/10/2016.
//  Copyright © 2016 Lawrence Dawson. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit


extension UIViewController{
	
func addNewMessage(message: Message) {
	add(message: message)
	startMonitoring(message: message)
	saveAllMessages()
}

func loadAllMessages() {
	messages = []
	guard let savedItems = UserDefaults.standard.array(forKey: PreferencesKeys.savedItems) else { return }
	for savedItem in savedItems {
		guard let message = NSKeyedUnarchiver.unarchiveObject(with: savedItem as! Data) as? Message else { continue }
		add(message: message)
	}
}

func saveAllMessages() {
	var items: [Data] = []
	for message in messages {
		let item = NSKeyedArchiver.archivedData(withRootObject: message)
		items.append(item)
	}
}

func add(message: Message) {
	messages.append(messages)
	// should we display them on the map too???
	// map.addAnnotation(notification)
	// addRadiusOverlay(forNotification: notifications)
	// also, may be good to call a method updating status of the message to 'delivered'?
	// (tbd)
	updateMessagesCount()
}

func remove(message: Message) {
	if let indexInArray = message.index(of: message) {
		messages.remove(at: indexInArray)
	}
	// map.removeAnnotion(message)
	// removeRadiusOverlay(forMessage: message)
	updateMessagesCount()
}

func updateMessagesCount() {
	//title = "Notifications (\(notifications.count))"
	//add a logic to ensure notifications.count < 20, iOS cannot handle more than that and may stop displaying them at all
	print("Messages (\(messages.count))")
}

func region(withMessage message: Message) -> CLCircularRegion {
	let region = CLCircularRegion(center: message.coordinate, radius: message.radius, identifier: message.id)
	region.notifyOnEntry = (message.eventType == .onEntry)
	region.notifyOnExit = !region.notifyOnEntry
	return region
}

func startMonitoring(message: Message) {
	if !CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
		showAlert(withTitle:"Error", message: "This device does not fully support Türfy, some functionalities may not work correctly")
		return
	}
	if CLLocationManager.authorizationStatus() != .authorizedAlways {
		showAlert(withTitle:"Warning", message: "Please grant Türfy permission to access the device location (Always on) in order for the app to work correctly")
	}
	let region = self.region(withMessage: message)
	locationManager.startMonitoring(for: region)
}

func stopMonitoring(message: Message) {
	for region in messageManager.monitoredRegions {
		guard let circularRegion = region as? CLCircularRegion, circularRegion.identifier == message.id else { continue }
		locationManager.stopMonitoring(for: circularRegion)
	}
}
}
