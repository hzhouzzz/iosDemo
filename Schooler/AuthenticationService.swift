//
//  AuthenticationService.swift
//  WhatsAppClone
//
//  Created by Frezy Stone Mboumba on 7/20/16.
//  Copyright © 2016 Frezy Stone Mboumba. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase


struct AuthenticationService {
    
    var databaseRef: FIRDatabaseReference! {
        
        return FIRDatabase.database().reference()
    }
    
    var storageRef: FIRStorageReference! {
        
        return FIRStorage.storage().reference()
    }
    

    fileprivate func saveInfo(_ user: FIRUser!, username: String, password: String, school: String){
        
        let userInfo = ["email": user.email!, "username": username, "school": school, "uid": user.uid]
        
        let userRef = databaseRef.child("users").child(user.uid)
        
        userRef.setValue(userInfo)
        
        signIn(user.email!, password: password)
        
        
    }
    

    func signIn(_ email: String, password: String){
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
              
                if let user = user {
                    
                    print("\(user.displayName!) successfuly signed in")
                  
                    let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDel.logUser()
                }
                
            }else {
                
                let alertView =  SCLAlertView()
                alertView.showError("Caution", subTitle: error!.localizedDescription)
                
            }
        })
        
    }


    func signUp(_ email: String, username: String, password: String, repassword: String, school: String){
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                
                self.setUserInfo(user, username: username, password: password, repassword: repassword, school: school)
                let alertView =  SCLAlertView()
                alertView.showSuccess("Congratualations", subTitle: "Account has been created")
   
                
                
            }else {
                
                let alertView =  SCLAlertView()
                alertView.showError("Caution", subTitle: error!.localizedDescription)
            }
        })
        
    }
    
    

    fileprivate func setUserInfo(_ user: FIRUser!, username: String, password: String, repassword: String, school: String){
        
        let changeRequest = user.profileChangeRequest()
        changeRequest.displayName = username
        
        changeRequest.commitChanges(completion: { (error) in
            if error == nil {
                
                self.saveInfo(user, username: username, password: password, school: school)
            }
            else {
                
                let alertView =  SCLAlertView()
                alertView.showError("Caution", subTitle: error!.localizedDescription)
                
            }
            
        })
    }

}
