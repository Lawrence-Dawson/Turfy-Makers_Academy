//
//  Message.swift
//  Turfy
//
//  Created by Lawrence Dawson on 26/10/2016.
//  Copyright © 2016 Lawrence Dawson. All rights reserved.
//

import Foundation

struct Message {
	let id: Int
	let sender: String
	let recipient: String
	let text: String
	let location: String
	let radius: Int
	let sentAt: NSDate
	let expires: Int
	
	init(id: Int, sender: String, recipient: String, location: String, text:String, radius: Int, expires: Int = 10) {
		self.id = id
		self.sender = sender
		self.recipient = recipient
		self.text = text
		self.location = location
		self.radius = radius
		self.sentAt = NSDate()
		self.expires = expires
	}
    
    init(snapshot: FIRDataSnapshot) -> void {
        id = snapshot.key
    let snapshotValue = snapshot.value as! [String: AnyObject]
    sender = snapshot.value as! String
    recipient = snapshot.recipient as! String
    text = snapshot.text as! String
    location = snapshot.location as! String
    radius: Int
    sentAt: NSDate
    expires: Int
    }
    
	func toAnyObject() -> Any {
		return [
            "sender": sender,
            "recipient": recipient,
            "text": text,
            "location": location,
            "radius": radius,
            "sentAt": sentAt.hashValue,
            "expires": expires,
		]
	}
}
