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
    
    let ref = FIRDatabase.database().reference(withPath: "messages")
    
	override func viewDidLoad() {
		super.viewDidLoad()
		
//
		let message = Message(id: "1", sender: "Johnny", recipient: "Lawrence", location: "Makers Academy", text: "Hey Lawrence you're the best guy in the world!", radius: 30)
		let itemRef = self.ref.childByAutoId()
		itemRef.setValue(message.toAnyObject())
		
		ref.observe(.value, with: { snapshot in
			print(snapshot.value)
			})
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

