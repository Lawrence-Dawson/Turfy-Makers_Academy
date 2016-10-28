//
//  Message.swift
//  Turfy
//
//  Created by Lawrence Dawson on 26/10/2016.
//  Copyright © 2016 Lawrence Dawson. All rights reserved.
//

import Foundation
import Firebase

struct Message {
	let id: String
	let sender: String
	let recipient: String
	let text: String
	let location: String
	let radius: Int
	let sentAt: String
	let expires: Int
	let date = Date()
//	let myLocale = Locale(identifier: "bg_BG")

	
	init(id: String, sender: String, recipient: String, location: String, text:String, radius: Int, expires: Int = 10) {
		let dateformatter = DateFormatter()
		dateformatter.dateFormat = "MM/dd/yy h:mm a Z"
		let now = dateformatter.string(from: NSDate() as Date)

		self.id = id
		self.sender = sender
		self.recipient = recipient
		self.text = text
		self.location = location
		self.radius = radius
		self.sentAt = now
		self.expires = expires
		
	}
    
    init(snapshot: FIRDataSnapshot) {
		id = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
            sender = snapshotValue["sender"] as! String
            recipient = snapshotValue["recipient"] as! String
            text = snapshotValue["text"] as! String
            location = snapshotValue["location"] as! String
            radius = snapshotValue["radius"] as! Int
            sentAt = snapshotValue["sentAt"] as! String
            expires = snapshotValue["expires"] as! Int
		
		}
	
	
	func toAnyObject() -> Any {
		return [
            "sender": sender,
            "recipient": recipient,
            "text": text,
            "location": location,
            "radius": radius,
            "sentAt": sentAt,
            "expires": expires,
		]
	}
}
