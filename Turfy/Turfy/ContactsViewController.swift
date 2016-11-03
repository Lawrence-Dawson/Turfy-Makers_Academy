//
//  ContactsViewController.swift
//  Turfy
//
//  Created by James Stonehill on 25/10/2016.
//  Copyright © 2016 Lawrence Dawson. All rights reserved.
//

import UIKit
import Firebase


class ContactsViewController: UIViewController {
	
	var usersArray = [User]
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
	
	func loadUsers(){
		
		let usersRef = FIRDatabase.database().reference().child("user")
		
		usersRef.observeSingleEvent(of: .value, with: { (snapshot) in
			
			var allUsers = [User]()
			
			for user in snapshot.children {
				
				let newUser = User(snapshot: user as! FIRDataSnapshot)
				allUsers.append(newUser)
			
			}
//			usersArray.sortInPlace {(user1:User, user2:User) -> Bool in
//				user.name < user.name
//			})
			
//			self.usersArray = allUsers.sort(by: { (user1, user2) -> Bool in
//				user1.name < user2.name
//			})
			
			self.tableView.reloadData()
			
			
			
		}) { (error) in
			print("Error Loading contacts from Firebase")
	}

}
}
