//
//  RecipientListViewController.swift
//  Turfy
//
//  Created by James Stonehill on 01/11/2016.
//  Copyright © 2016 Lawrence Dawson. All rights reserved.
//

import UIKit
import Firebase


class RecipientListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var selectedRecipient: [String:String] = ["":""]
    var contacts: [[String : String]] = [["blank" : "blank"]]
    var name: String = "", email: String = "", uid: String = "";
    let ref = FIRDatabase.database().reference().child("user")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("IN VIEWDIDLOAD")
        print(contacts)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = contacts[indexPath.row]["name"]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRecipient = contacts[indexPath.row]
    
        self.performSegue(withIdentifier: "goToCompose", sender:self)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let composeVC:ComposeViewController = segue.destination as! ComposeViewController
        composeVC.recipient = selectedRecipient
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
