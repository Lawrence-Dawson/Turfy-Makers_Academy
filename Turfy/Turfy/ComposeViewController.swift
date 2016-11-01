//
//  ComposeViewController.swift
//  Turfy
//
//  Created by Joseph Huang on 27/10/2016.
//  Copyright © 2016 Lawrence Dawson. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class ComposeViewController: UIViewController {
	var longitude: Double = 0
	var latitude: Double = 0
    var radius: Float = 0
    let user = FIRAuth.auth()?.currentUser
	let ref = FIRDatabase.database().reference().child("messages")
	
    var recipient: [String:String] = ["name":"Select Recipient"]
    
    @IBOutlet weak var recipientButtonField: UIButton!
    var message: Message?
    
    @IBOutlet weak var radiusText: UILabel!
    @IBOutlet weak var radiusSlider: UISlider!
    @IBOutlet weak var messageText: UITextView!
    
    @IBAction func radiusSlider(_ sender: UISlider) {
        radiusText.text = "\(Int(radiusSlider.value))"
        radius = radiusSlider.value
    }
    
    @IBAction func submitMessage(_ sender: AnyObject) {
		let messageRecipient = recipient["uid"]
		let message: Message = Message(id: "", sender: (user?.displayName)!, recipient: messageRecipient!, text: messageText.text, latitude: Coordinates.latitude, longitude: Coordinates.longitude, radius: Double(radius), eventType: "On Entry")
		saveData(message: message)
    }
	
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
        
        recipientButtonField.setTitle("Recipient: \(recipient["name"]!)", for: UIControlState.normal)
        
        print(recipient)
        
        // some styling for the text field
        messageText!.layer.borderWidth = 1

        radiusText.text = "\(Int(radiusSlider.value))"
        radius = radiusSlider.value
    }
	
	func saveData(message: Message) {
		        let recipient: String = message.recipient
		        let messageContent = message.toAnyObject()
		        let itemRef = self.ref.child(recipient).childByAutoId()
		        itemRef.setValue(messageContent)
		    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.§
    }

	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // helper methods
    

}
