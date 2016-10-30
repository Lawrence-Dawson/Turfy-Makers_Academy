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
		//retrieveMessageAttributes(messageID: "-KVA7xvDvdTQ61GMDyST")
        saveData(id: "test message", sender: "Johnny", recipient: "Lawrence", text: "This app is going to be great!", latitude: 50.00, longitude: 0.00 , radius: 500, eventType: "On Entry")
	}

	
	let ref = FIRDatabase.database().reference().child("messages")
	let dateformatter = DateFormatter()

	

	func retrieveMessageAttributes(messageID: String) {
		ref.queryOrderedByKey().queryEqual(toValue: messageID).observe(.value, with: { (snapshot) in
			print(snapshot)
			for item in snapshot.children {
				let data = (item as! FIRDataSnapshot).value! as! NSDictionary
                
                let id = messageID
                let sender = (data["sender"])!
                let recipient = (data["recipient"])!
                let text = (data["text"])!
                let latitude = (data["latitude"])!
                let longitude = (data["longitude"])!
                let radius = (data["radius"])!
                let eventType = (data["eventType"])!
        
                
				let sentAtStr = (data["sentAt"])!
				self.dateformatter.dateFormat = "dd/MM/yy h:mm"
				let sentAtDate = self.dateformatter.date(from: sentAtStr as! String)
				self.dateformatter.dateFormat = "dd/MM/yy h:mm"
				let sentAt = self.dateformatter.string(from: sentAtDate!)
                
                let expiresAtStr = (data["expires"])!
                let expiresDate = self.dateformatter.date(from: expiresAtStr as! String)
                self.dateformatter.dateFormat = "dd/MM/yy h:mm"
                let expires = self.dateformatter.string(from: expiresDate!)
                
                print(id)
				print(sender)
				print(recipient)
				print(text)
				print(radius)
				print(sentAt)
                print(latitude)
                print(longitude)
                print(eventType)
                print(expires)
			}
		})
	}
	
    
    func saveData(id: String, sender: String, recipient: String, text: String, latitude: Double, longitude: Double, radius: Double, eventType: String, expires: Int = 2) {

        let message = Message(id: id, sender: sender, recipient: recipient, text: text, latitude: latitude, longitude: longitude, radius: radius, eventType: eventType, expires: expires)
        
        let itemRef = self.ref.childByAutoId()
        itemRef.setValue(message.toAnyObject())
    }
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}

