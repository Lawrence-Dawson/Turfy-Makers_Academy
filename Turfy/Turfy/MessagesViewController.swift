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
	let ref = FIRDatabase.database().reference().child("messages")

	func retrieveMessageAttributes() {
		ref.queryOrderedByKey().queryEqual(toValue: "-KV4T3PQzUuNuOKkjEX1").observe(.value, with: { (snapshot) in
			print(snapshot)
			for item in snapshot.children {
				let data = (item as! FIRDataSnapshot).value! as! NSDictionary
				print("*********************")
				print((data["text"])!)
			}
		})
	}
	
    
    func saveData() {
        let message = Message(id: "1", sender: "James", recipient: "Lawrence", location: "Makers Academy", text: "Hey James is awesome!", radius: 30)
        let itemRef = self.ref.childByAutoId()
        itemRef.setValue(message.toAnyObject())
		

    }
    
    func printData() {
        ref.observe(.value, with: { snapshot in
			 print(snapshot.value)
        })

    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
//        saveData()
//        print(printData())
		retrieveMessageAttributes()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

