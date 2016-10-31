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
	
//	let uid = (FIRAuth.auth()?.currentUser?.uid)!
//    let ref = FIRDatabase.database().reference().child("messages")
//    let inboxRef = FIRDatabase.database().reference().child("messages").child((FIRAuth.auth()?.currentUser?.uid)!)
	
//	let sampleMessage : Message = Message(id: "test message", sender: (FIRAuth.auth()?.currentUser?.uid)!, recipient: "zwcxlPQwDAhYIxX9k4hDn77LvQY2", text: "Hey Johnny!", latitude: 50.00, longitude: 0.00, radius: 500, eventType: "On Entry")
	
	override func viewDidLoad() {
		super.viewDidLoad()
//		saveData(message: sampleMessage)
//		
//        inboxRef.observe(.childAdded, with: { (snapshot) -> Void in
//            print(snapshot)
//			
//			let message = Message(snapshot: snapshot)
//			print(message.toAnyObject())
//			//addNewMessage(message: message)
//        })
//		
	}
    
//	func saveData(message: Message) {
//
//		let recipient: String = message.recipient
//		let messageContent = message.toAnyObject()
//        
//        let itemRef = self.ref.child(recipient).childByAutoId()
//        itemRef.setValue(messageContent)
//    }
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}

