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
    
    let record = FIRDatabase.database().reference(withPath: "messages/james")
    
    func saveData() {
        let message = Message(id: "1", sender: "James", recipient: "Lawrence", location: "Makers Academy", text: "Hey James is awesome!", radius: 30)
        let itemRef = self.record.childByAutoId()
        itemRef.setValue(message.toAnyObject())
        

    }
    
    func printData() {
        record.observe(.value, with: { snapshot in
            print(snapshot.value)
        })

    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        saveData()
        print(printData())
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

