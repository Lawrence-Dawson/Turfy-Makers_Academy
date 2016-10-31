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
//    let providerID: String
    let uid: String
    let name: String
    let email: String
    
    init(uid: String, name: String, email: String) {
        self.uid = uid
        self.name = name
        self.email = email
    }
    
    init(snapshot: FIRDataSnapshot) {
        uid = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        email = snapshotValue["email"] as! String
        
    }
    
    
    func toAnyObject() -> [String: String] {
        return [
            "uid": uid,
            "name": name,
            "email": email,
        ]
    }
}
