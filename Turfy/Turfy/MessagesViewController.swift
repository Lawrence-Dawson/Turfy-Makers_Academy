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
	
	let uid = (FIRAuth.auth()?.currentUser?.uid)!
    let ref = FIRDatabase.database().reference().child("messages")
    let inboxRef = FIRDatabase.database().reference().child("messages").child((FIRAuth.auth()?.currentUser?.uid)!)
	let sampleMessage : Message = Message(id: "test message", sender: (FIRAuth.auth()?.currentUser?.uid)!, recipient: "zwcxlPQwDAhYIxX9k4hDn77LvQY2", text: "Hey Johnny!", latitude: 50.00, longitude: 0.00, radius: 500, eventType: "On Entry")
	
    let dateformatter = DateFormatter()
	override func viewDidLoad() {
		super.viewDidLoad()
		saveData(message: sampleMessage)
       // saveData(id: "test message", sender: "Johnny", recipient: "Lawrence", text: "This app is going to be great!", latitude: 50.00, longitude: 0.00 , radius: 500, eventType: "On Entry")
        inboxRef.observe(.childAdded, with: { (snapshot) -> Void in
            print(snapshot)
			
			let message = Message(snapshot: snapshot)
			print(message.toAnyObject())
			//addNewMessage(message: message)
        })
		
	}

	




	//func retrieveMessageAttributes(messageID: String) {
	//	inboxRef.queryOrderedByKey().queryEqual(toValue: messageID).observe(.value, with: { (snapshot) in
	//		print(snapshot)
	//		for item in snapshot.children {
	//			let data = (item as! FIRDataSnapshot).value! as! NSDictionary
                
     //           let id = messageID
     //           let sender = (data["sender"])!
     //           let recipient = (data["recipient"])!
     //           let text = (data["text"])!
     //           let latitude = (data["latitude"])!
     //           let longitude = (data["longitude"])!
     //           let radius = (data["radius"])!
      //          let eventType = (data["eventType"])!
        
                
	//			let sentAtStr = (data["sentAt"])!
	//			self.dateformatter.dateFormat = "dd/MM/yy h:mm"
	//			let sentAtDate = self.dateformatter.date(from: sentAtStr as! String)
	//			self.dateformatter.dateFormat = "dd/MM/yy h:mm"
	//			let sentAt = self.dateformatter.string(from: sentAtDate!)
      //
        //        let expiresAtStr = (data["expires"])!
         //       let expiresDate = self.dateformatter.date(from: expiresAtStr as! String)
          //      self.dateformatter.dateFormat = "dd/MM/yy h:mm"
           //     let expires = self.dateformatter.string(from: expiresDate!)
                
           //     print(id)
			//	print(sender)
		//		print(recipient)
	//			print(text)
	//			print(radius)
	//			print(sentAt)
      //          print(latitude)
        //        print(longitude)
          //      print(eventType)
           //     print(expires)
	//		}
	//	})
//	}
	
    
	func saveData(message: Message) {

		let recipient: String = message.recipient
		let messageContent = message.toAnyObject()
        
        let itemRef = self.ref.child(recipient).childByAutoId()
        itemRef.setValue(messageContent)
    }
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}

