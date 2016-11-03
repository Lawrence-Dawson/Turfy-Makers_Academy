//
//  ContactsViewController.swift
//  Turfy
//
//  Created by James Stonehill on 25/10/2016.
//  Copyright © 2016 Lawrence Dawson. All rights reserved.
//


import UIKit
import Firebase


class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var usersArray: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUsers()
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
    
    func loadUsers(){
        
        let usersRef = FIRDatabase.database().reference().child("user")
        
        usersRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            var allUsers = [String]()
            
            for user in snapshot.children {
                
                let newUser = User(snapshot: user as! FIRDataSnapshot)
                allUsers.append(newUser.name)
                
            }
            //            usersArray.sortInPlace {(user1:User, user2:User) -> Bool in
            //                user.name < user.name
            //            })
            
            //            self.usersArray = allUsers.sort(by: { (user1, user2) -> Bool in
            //                user1.name < user2.name
            //            })
            
            self.usersArray = allUsers
            
            
            
            
            
        }) { (error) in
            print("Error Loading contacts from Firebase")
        }
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "singleCell", for: indexPath)
        //let user = usersArray[indexPath.row]
        
        cell.textLabel?.text = usersArray[indexPath.row]
        //cell.detailTextLabel?.text = user.email
        //var url:NSURL = NSURL.URLWithString([indexPath.row]["url"])
        //cell.imageView?
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedUser = usersArray[indexPath.row]
        
        //self.performSegue(withIdentifier: "goToCompose", sender:self)
    }
    
}
