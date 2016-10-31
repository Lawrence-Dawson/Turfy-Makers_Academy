//
//  Message.swift
//  Turfy
//
//  Created by Lawrence Dawson on 26/10/2016.
//  Copyright © 2016 Lawrence Dawson. All rights reserved.
//

import Foundation

import Firebase
import UIKit
import MapKit
import CoreLocation

struct MessageKey {
	static let id = "id"
	static let sender = "sender"
	static let recipient = "recipient"
	static let text = "text"
	static let latitude = "latitude"
	static let longitude = "longitude"
	static let radius = "radius"
	static let eventType = "eventType"
	static let sentAt = "sentAt"
	static let expires = "expires"
    static let status = "status"
}


enum EventType: String {
    case onEntry = "On Entry"
    case onExit = "On Exit"
}

enum Status: String {
    case sent = "Sent"
    case delivered = "Delivered"
}

class Message: NSObject, NSCoding {
	let id: String
	let sender: String
	let recipient: String
	let text: String

	let coordinate: CLLocationCoordinate2D
    let radius: CLLocationDistance
    let eventType: EventType
	let sentAt: String
	let expires: String
    let status: Status
    let dateformatter = DateFormatter()
    
	
    init(id: String, sender: String, recipient: String, text: String, latitude: Double, longitude: Double, radius: Double, eventType: String, expires: Int = 2, status: String = "Sent") {
		
		let timeInterval = expires*86400
		self.dateformatter.dateFormat = "dd/MM/yy h:mm"
		
		self.id = id
		self.sender = sender
		self.recipient = recipient
		self.text = text
		self.eventType = EventType(rawValue: eventType)!
		self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
		
		self.radius = CLLocationDistance(radius)
		self.sentAt = self.dateformatter.string(from: NSDate() as Date)
		self.expires = self.dateformatter.string(from: NSDate(timeIntervalSinceNow: Double(timeInterval)) as Date)
		self.status = Status(rawValue: status)!
	}
    
    //Parsing to FIR-friendly format
    func toAnyObject() -> Any {
        return [
            "sender": sender,
            "recipient": recipient,
            "text": text,
            "latitude": coordinate.latitude,
            "longitude": coordinate.longitude,
            "radius": radius,
            "eventType": eventType.rawValue,
            "sentAt": sentAt,
            "expires": expires,
            "status": status.rawValue
        ]
    }
    
    //Importing from FIRDataSnapshot object
    init(snapshot: FIRDataSnapshot) {
		id = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
            sender = snapshotValue["sender"] as! String
            recipient = snapshotValue["recipient"] as! String
            text = snapshotValue["text"] as! String
        
            coordinate = CLLocationCoordinate2D(latitude: snapshotValue["latitude"] as! Double, longitude: snapshotValue["longitude"] as! Double)
            radius = CLLocationDistance(snapshotValue["radius"] as! Double)
			eventType = EventType(rawValue: snapshotValue["eventType"] as! String)!
        
            sentAt = snapshotValue["sentAt"] as! String
            expires = snapshotValue["expires"] as! String
            status = Status(rawValue: snapshotValue["status"] as! String)!
		}
    
    required init?(coder decoder: NSCoder) {
		id = decoder.decodeObject(forKey: MessageKey.id) as! String
		sender = decoder.decodeObject(forKey: MessageKey.sender) as! String
		recipient = decoder.decodeObject(forKey: MessageKey.recipient) as! String
		text = decoder.decodeObject(forKey: MessageKey.text) as! String
		let latitude = decoder.decodeDouble(forKey: MessageKey.latitude)
		let longitude = decoder.decodeDouble(forKey: MessageKey.longitude)
		coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
		radius = CLLocationDistance(decoder.decodeDouble(forKey: MessageKey.radius))
		eventType = EventType(rawValue: decoder.decodeObject(forKey: MessageKey.eventType) as! String)!
		sentAt = decoder.decodeObject(forKey: MessageKey.sentAt) as! String
		expires = decoder.decodeObject(forKey: MessageKey.expires) as! String
        status = Status(rawValue: decoder.decodeObject(forKey: MessageKey.status) as! String)!
    }
	
    func encode(with coder: NSCoder) {
		coder.encode(id, forKey: MessageKey.id)
		coder.encode(sender, forKey: MessageKey.sender)
		coder.encode(recipient, forKey: MessageKey.recipient)
		coder.encode(text, forKey: MessageKey.text)
		coder.encode(coordinate.latitude, forKey: MessageKey.latitude)
		coder.encode(coordinate.longitude, forKey: MessageKey.longitude)
		coder.encode(radius, forKey: MessageKey.radius)
		coder.encode(eventType.rawValue, forKey: MessageKey.eventType)
		coder.encode(sentAt, forKey: MessageKey.sentAt)
		coder.encode(expires, forKey: MessageKey.expires)
        coder.encode(status.rawValue, forKey: MessageKey.status)
    }

}
