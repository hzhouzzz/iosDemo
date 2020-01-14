//
//  User.swift
//  Schooler
//
//  Created by Huang Zhou on 2017-04-01.
//  Copyright © 2017 Huang Zhou. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct User {
    
    var username: String!
    var email: String!
    var school: String!
    var uid: String!
    var ref: FIRDatabaseReference?
    var key: String
    
    init(snapshot: FIRDataSnapshot){
        
        key = snapshot.key
        ref = snapshot.ref
        guard let snapshotValue = snapshot.value as? NSDictionary else {
            print("Snapshot is nil hence no data returned")
            return
        }
        
        username = snapshotValue["username"] as! String
        email = snapshotValue["email"] as! String
        school = snapshotValue["school"] as! String
        uid = snapshotValue["uid"] as! String
        
    }
}
