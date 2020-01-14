//
//  MessageTableViewController.swift
//  Schooler
//
//  Created by Huang Zhou on 2017-04-21.
//  Copyright © 2017 Huang Zhou. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class MessageTableViewController: UITableViewController{
    
    

    @IBOutlet var tableview: UITableView!
    var searchController: UISearchController!
    
    var dataBaseRef: FIRDatabaseReference! {
        
        return FIRDatabase.database().reference()
    }
    
    var storageRef: FIRStorage {
        
        return FIRStorage.storage()
    }
    
    var users = [User]()
    //updated code
    var username:[String: [String]] = [String: [String]]()
    var email:[String: [String]] = [String: [String]]()
    var keys:[String] = []
    var filteredNames: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.delegate = self
        self.tableview.dataSource = self
        
        //tableview.register(UITableViewCell.self, forCellReuseIdentifier: "messageCell")
        
        //let path = Bundle.main.path(forResource: "sortednames", ofType: "plist")
        //let nameDict = NSDictionary(contentsOfFile: path!)
        //username = nameDict as! [String: [String]]
        //keys = (nameDict!.allKeys as! [String]).sorted()
        
        //let resultsController = SearchResultController
        //resultsController.username = username
        //resultsController.keys = keys
        //searchController = UISearchController(searchResultsController: resultsController)
    }
    
    //func updateSearchResults(for searchController: UISearchController) {
        //let filter: (String) -> Bool = {username in
            //let nameLength =  username.characters.count
        //}
    //}
    
    override func viewWillAppear(_ animated: Bool) {
        
        let usersRef = dataBaseRef.child("users")
        usersRef.observe(.value, with: { (snapshot) in
            
            var allUsers = [User]()
            
            for user in snapshot.children {
                
                let myself = User(snapshot: user as! FIRDataSnapshot)
                
                if myself.username != FIRAuth.auth()!.currentUser!.displayName! {
                    
                    let newUser = User(snapshot: user as! FIRDataSnapshot)
                    allUsers.append(newUser)
                }
                
            }
            self.users = allUsers
            self.tableView.reloadData()
            
            
        }) { (error) in
            
            let alertView = SCLAlertView()
            alertView.showError("Caution", subTitle: error.localizedDescription)
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 106
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showChat", sender: self)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageTableViewCell
        
        
        cell.usernameLabel.text = users[indexPath.row].username
        cell.userEmailLabel.text = users[indexPath.row].email
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showChat" {
            
            let chatViewController = segue.destination as! ChatViewController
            chatViewController.senderId = FIRAuth.auth()!.currentUser!.uid
            chatViewController.senderDisplayName = FIRAuth.auth()!.currentUser!.displayName!
            
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        self.users.remove(at: indexPath.row)
        self.tableview.reloadData()
    }
    
    

}
