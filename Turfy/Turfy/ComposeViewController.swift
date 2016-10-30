//
//  ComposeViewController.swift
//  Turfy
//
//  Created by Joseph Huang on 27/10/2016.
//  Copyright © 2016 Lawrence Dawson. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    var longitude: Double = 0
    var latitude: Double = 0
    
    @IBAction func radiusSlider(_ sender: UISlider) {
        radius.text = String(Int(sender.value))
    }
    
    @IBOutlet weak var radius: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


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
