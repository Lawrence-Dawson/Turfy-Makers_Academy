//
//  ContactsViewController.swift
//  Turfy
//
//  Created by James Stonehill on 25/10/2016.
//  Copyright © 2016 Lawrence Dawson. All rights reserved.
//

import UIKit
import Firebase

class ContactsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let ref = FIRDatabase.database().reference().child("user")
    var selectedRecipient: [String:String] = ["":""]
    var emptyArrayOfDictionary = [[String : String]]()
    var name: String = "", email: String = "", uid: String = "";
    var recipient: [String:String] = ["name":"Select Recipient"]


    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = emptyArrayOfDictionary[indexPath.row]["name"]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emptyArrayOfDictionary.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRecipient = emptyArrayOfDictionary[indexPath.row]
        
        self.performSegue(withIdentifier: "goToCompose", sender:self)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let composeVC:ComposeViewController = segue.destination as! ComposeViewController
        composeVC.recipient = selectedRecipient
    }
    
    func retrieveData() {
        ref.observe(.value, with: { snapshot in
            for child in snapshot.children {
                let data = (child as! FIRDataSnapshot).value! as! [String:String]
                let uid = (data["uid"])!
                let name = (data["name"])!
                let email = (data["email"])!
                self.emptyArrayOfDictionary.append(["uid": uid , "name": name, "email": email])
            }
        })
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
