//
//  AllMessagesViewController.swift
//  Turfy
//
//  Created by Joseph Huang on 31/10/2016.
//  Copyright © 2016 Lawrence Dawson. All rights reserved.
//

import UIKit
import Firebase
import MapKit

class AllMessagesViewController: UITableViewController {
    
    let inboxRef = FIRDatabase.database().reference().child("messages").child((FIRAuth.auth()?.currentUser?.uid)!)

    var messages: [Message] = []
    

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        inboxRef.observe(.value, with: { snapshot in

            var newMessages: [Message] = []
            
            for allMessages in snapshot.children{
                let message = Message(snapshot: allMessages as! FIRDataSnapshot)
                newMessages.append(message)

            }
            print(self.messages)
            self.messages = newMessages
            self.tableView.reloadData()
        })
        print()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMessage", let destination = segue.destination as? SingleMessageViewController {
            if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell){
            destination.textMessage = (cell.textLabel?.text)!
            destination.coordMessage = messages[indexPath.row].coordinate
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        cell.textLabel?.text = messages[indexPath.row].text
        cell.detailTextLabel?.text = messages[indexPath.row].sender

        return cell
    }


}
