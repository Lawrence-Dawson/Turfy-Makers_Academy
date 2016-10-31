//
//  ComposeViewController.swift
//  Turfy
//
//  Created by Joseph Huang on 27/10/2016.
//  Copyright © 2016 Lawrence Dawson. All rights reserved.
//

import UIKit
import FirebaseAuth

class ComposeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var longitude: Double = 0
    var latitude: Double = 0
    var radius: Float = 0
    let user = FIRAuth.auth()?.currentUser
    let recipient: FIRUser? = nil
    var message: Message?
    
    
    var dataArray = [String]()
    var filteredArray = [String]()
    var shouldShowSearchResults = false
    
    @IBOutlet weak var tblSearchResults: UITableView!
    
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
        
        dataArray = ["Onee"]
        
        tblSearchResults.delegate = self
        tblSearchResults.dataSource = self
        tblSearchResults.reloadData()

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.§
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults {
            return filteredArray.count
        }
        else {
            return dataArray.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("in tableView")
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "idCell", for: indexPath as IndexPath) as! UITableViewCell
        
        if shouldShowSearchResults {
            cell.textLabel?.text = filteredArray[indexPath.row]
            print("tests if it is in the true part of the statement")
        }
        else {
            print("should be inputing the text into the cell")
            print("\(dataArray[0])")
            //cell.textLabel?.text = dataArray[indexPath.row]
            cell.textLabel?.text = dataArray[0]
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
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
