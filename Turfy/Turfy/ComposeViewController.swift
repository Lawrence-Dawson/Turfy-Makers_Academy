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

class ComposeViewController: UIViewController, UITextViewDelegate {
	var longitude: Double = 0
	var latitude: Double = 0
    var radius: Float = 0
    let user = FIRAuth.auth()?.currentUser
	let ref = FIRDatabase.database().reference().child("messages")
	var eventType = "On Entry"
	
	@IBAction func toggle(_ sender: UISegmentedControl){
		if sender.selectedSegmentIndex == 0 {
			eventType = "On Entry"
		} else if sender.selectedSegmentIndex == 1 {
			eventType = "On Exit"
		}
	}
	
	
    var recipient: [String:String] = ["name":"Select Recipient"]
    
    @IBOutlet weak var recipientButtonField: UIButton!
    var message: Message?
    
    let placeholderText = "Write your message here..."
    
    @IBOutlet weak var radiusText: UILabel!
    @IBOutlet weak var radiusSlider: UISlider!
    @IBOutlet weak var messageText: UITextView!
    
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBAction func radiusSlider(_ sender: UISlider) {
        radiusText.text = "\(Int(radiusSlider.value))"
        radius = radiusSlider.value
    }
    
    @IBAction func submitMessage(_ sender: AnyObject) {
		let messageRecipient = recipient["uid"]
		let message: Message = Message(id: "", sender: (user?.displayName)!, recipient: messageRecipient!, text: messageText.text, latitude: MapVariables.latitude, longitude: MapVariables.longitude, radius: Double(radius), eventType: eventType)
		saveData(message: message)
    }
	
    
    func textViewDidEndEditing(_ theTextView: UITextView) {
        if !messageText.hasText {
            placeholderLabel.isHidden = false
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if !messageText.hasText {
            placeholderLabel.isHidden = false
        }
        else {
            placeholderLabel.isHidden = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        messageText.delegate = self

        //styling for the textbox
            messageText.layer.cornerRadius = 5
            messageText.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
            messageText.layer.borderWidth = 0.5
            messageText.clipsToBounds = true
        

        placeholderLabel.text = placeholderText
        // placeholderLabel is instance variable retained by view controller
        placeholderLabel.backgroundColor = UIColor.clear
        placeholderLabel.textColor = UIColor.lightGray
        // textView is UITextView object you want add placeholder text to
        messageText.addSubview(placeholderLabel)
        

        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        recipientButtonField.setTitle("Recipient: \(recipient["name"]!)", for: UIControlState.normal)
        
        print(recipient)
        

        radiusText.text = "\(Int(radiusSlider.value))"
        radius = radiusSlider.value
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
