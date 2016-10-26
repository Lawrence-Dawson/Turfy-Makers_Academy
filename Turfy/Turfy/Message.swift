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
	
	func toAnyObject() -> Any {
		return [
			"id": id,
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
