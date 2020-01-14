//
//  profileViewController.swift
//  Schooler
//
//  Created by Huang Zhou on 2017-04-01.
//  Copyright © 2017 Huang Zhou. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class profileViewController: UIViewController {

    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var school: UILabel!
    
    @IBAction func onButtonPressed(_ sender: UIButton) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        self.present(loginVC!, animated: true, completion: nil)
    }
    
    
    @IBAction func settingButton(_ sender: UIButton) {
        
    }
    
    
    var dataBaseRef: FIRDatabaseReference! {
        
        return FIRDatabase.database().reference()
    }
    
    var storageRef: FIRStorage! {
        
        return FIRStorage.storage()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadUserInfo()
    }
    
    func loadUserInfo(){
        
        let userRef = dataBaseRef.child("users/\(FIRAuth.auth()!.currentUser!.uid)")
        userRef.observe(.value, with: { (snapshot) in
            
            let user = User(snapshot: snapshot)
            
            self.username.text = user.username
            self.school!.text = "School: \(user.school!)"
            self.email!.text = "Email: \(user.email!)"
            
        }) { (error) in
            
            let alertView = SCLAlertView()
            alertView.showError("Caution", subTitle: error.localizedDescription)
        }
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
