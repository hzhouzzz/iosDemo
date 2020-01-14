//
//  Message.swift
//  Schooler
//
//  Created by Huang Zhou on 2017-04-21.
//  Copyright © 2017 Huang Zhou. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Message {
    
    var text: String!
    var senderId: String!
    var username: String!
    var mediaType: String!
    var mediaUrl: String!
    var ref: FIRDatabaseReference!
    var key: String = ""
    
    init(snapshot: FIRDataSnapshot){
        
        self.text = (snapshot.value as! NSDictionary)["text"] as! String
        self.senderId = (snapshot.value as! NSDictionary)["senderId"] as! String
        self.username = (snapshot.value as! NSDictionary)["username"] as! String
        self.mediaType = (snapshot.value as! NSDictionary)["mediaType"] as! String
        self.mediaUrl = (snapshot.value as! NSDictionary)["mediaUrl"] as! String
        self.key = snapshot.key
        self.ref = snapshot.ref
        
    }
    
    init(text: String, key: String = "", senderId: String, username: String, mediaType: String, mediaUrl: String){
        
        self.text = text
        self.senderId = senderId
        self.username = username
        self.mediaUrl = mediaUrl
        self.mediaType = mediaType
        
    }
    
    
    func toAnyObject() -> [String: AnyObject]{
        
        return ["text": text as AnyObject,"senderId": senderId as AnyObject, "username": username as AnyObject,"mediaType":mediaType as AnyObject, "mediaUrl":mediaUrl as AnyObject]
    }
    
    
    
    
}
