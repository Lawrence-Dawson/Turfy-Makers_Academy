//
//  User.swift
//  Turfy
//
//  Created by Tam Borine on 30/10/2016.
//  Copyright © 2016 Lawrence Dawson. All rights reserved.
//

import Foundation
import Firebase

struct User {
    let providerID: String
    let uid: String
    let name: String
    let email: String
    let photoURL: String

    
    
    init(providerID: String, uid: String, name: String, email: String, photoURL: String) {
        
      //  self.dateformatter.dateFormat = "dd/MM/yy h:mm"
      //  let now = self.dateformatter.string(from: NSDate() as Date)
        
        self.providerID = uid
        self.uid = uid
        self.name = name
        self.email = email
        self.photoURL = photoURL

        
    }
    
    init(snapshot: FIRDataSnapshot) {
        uid = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        providerID = snapshotValue["providerID"] as! String
        name = snapshotValue["name"] as! String
        email = snapshotValue["email"] as! String
        photoURL = snapshotValue["photoURL"] as! String
        
    }
    
    
    func toAnyObject() -> Any {
        return [
            "providerID": providerID,
            "uid": uid,
            "name": name,
            "email": email,
            "photoURL": photoURL,
        ]
    }
}
