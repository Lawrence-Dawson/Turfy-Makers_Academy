//
//  ComposeViewController.swift
//  Turfy
//
//  Created by Joseph Huang on 27/10/2016.
//  Copyright © 2016 Lawrence Dawson. All rights reserved.
//

import UIKit
import FirebaseAuth

class ComposeViewController: UIViewController {
    var longitude: Double = 0
    var latitude: Double = 0
    var radius: Float = 0
    let user = FIRAuth.auth()?.currentUser
    let recipient: FIRUser? = nil
    var message: Message?

    
    @IBOutlet weak var radiusText: UILabel!
    @IBOutlet weak var radiusSlider: UISlider!
    @IBOutlet weak var messageText: UITextView!
    
    @IBAction func radiusSlider(_ sender: UISlider) {
        radiusText.text = "\(Int(radiusSlider.value))"
        radius = radiusSlider.value
    }
    
    @IBAction func submitMessage(_ sender: AnyObject) {
 
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
        
        // some styling for the text field
        messageText!.layer.borderWidth = 1

        radiusText.text = "\(Int(radiusSlider.value))"
        radius = radiusSlider.value
 
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
