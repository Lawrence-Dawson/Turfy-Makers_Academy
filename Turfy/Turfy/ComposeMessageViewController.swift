//
//  ComposeMessageViewController.swift
//  Turfy
//
//  Created by James Hamann on 28/10/2016.
//  Copyright © 2016 Lawrence Dawson. All rights reserved.
//

import UIKit
import QuartzCore

class ComposeMessageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        taskNotes.layer.borderWidth = 0.5
        taskNotes.layer.borderColor = borderColor.cgColor
        taskNotes.layer.cornerRadius = 5.0
    }
    

    @IBOutlet weak var taskNotes: UITextView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
