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
		// Do any additional setup after loading the view, typically from a nib.
        // The code below saves shit in the DB, created a field 'lastTested' and assigns a value 'testing_lalala' to it
//        let testItemRef = self.ref.child("lastTested")
//        testItemRef.setValue("testing_lalala")
		let message = Message(id: "1", sender: "Johnny", recipient: "Lawrence", location: "Makers Academy", text: "Hey Lawrence you're the best guy in the world!", radius: 30)
		let itemRef = self.ref.childByAutoId()
		itemRef.setValue(message.toAnyObject())
		
		ref.observe(.value, with: { snapshot in
			print(snapshot.value)
			})
		
//
		
        
//            self.ref.observeSingleEventOfType(.value, withBlock: { (snapshot) in
//            
//            if !snapshot.exists() { return }
//            print(snapshot)
//            
//        })
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

