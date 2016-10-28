//
//  FirstViewController.swift
//  Turfy
//
//  Created by Lawrence Dawson on 25/10/2016.
//  Copyright © 2016 Lawrence Dawson. All rights reserved.
//

import UIKit
import Firebase

class MessagesViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		retrieveMessageAttributes(messageID: "-KV4T3PQzUuNuOKkjEX1")
		
	}

	
	let ref = FIRDatabase.database().reference().child("messages")

	func retrieveMessageAttributes(messageID: String) {
		ref.queryOrderedByKey().queryEqual(toValue: messageID).observe(.value, with: { (snapshot) in
			print(snapshot)
			for item in snapshot.children {
				let data = (item as! FIRDataSnapshot).value! as! NSDictionary
				let sender = (data["sender"])!
				let recipient = (data["recipiet"])!
				let location = (data["location"])!
				let text = (data["text"])!
				let radius = (data["radius"])!
				let sentAt = (data["sentAt"])!
			}
		})
	}
	
    
    func saveData(id: String, sender: String, recipient: String, location: String, text: String, radius: Int) {
		
        let message = Message(id: id, sender: sender, recipient: recipient, location: location, text: text, radius: radius)
        let itemRef = self.ref.childByAutoId()
        itemRef.setValue(message.toAnyObject())
    }
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}

