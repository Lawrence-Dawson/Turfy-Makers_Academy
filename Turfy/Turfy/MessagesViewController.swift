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
		retrieveMessageAttributes(messageID: "-KVA7xvDvdTQ61GMDyST")
		saveData(id: "4", sender: "Lawrence", recipient: "Johnny", location: "Poland", text: "FINAL DATE TEST!", radius: 5)
	}

	
	let ref = FIRDatabase.database().reference().child("messages")
	let dateformatter = DateFormatter()

	

	func retrieveMessageAttributes(messageID: String) {
		ref.queryOrderedByKey().queryEqual(toValue: messageID).observe(.value, with: { (snapshot) in
			print(snapshot)
			for item in snapshot.children {
				let data = (item as! FIRDataSnapshot).value! as! NSDictionary
				let sender = (data["sender"])!
				let recipient = (data["recipient"])!
				let location = (data["location"])!
				let text = (data["text"])!
				let radius = (data["radius"])!
				
				let sentAtStr = (data["sentAt"])!
				self.dateformatter.dateFormat = "dd/MM/yy h:mm"
				let date = self.dateformatter.date(from: sentAtStr as! String)
				self.dateformatter.dateFormat = "dd/MM/yy h:mm"
				let sentAt = self.dateformatter.string(from: date!)

				print(sender)
				print(recipient)
				print(location)
				print(text)
				print(radius)
				print(sentAt)
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

