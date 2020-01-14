//
//  LoginViewController.swift
//  Schooler
//
//  Created by Huang Zhou on 2017-03-17.
//  Copyright © 2017 Huang Zhou. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var UsernameTextField: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    var authService = AuthenticationService()
    
    @IBAction func LoginButton(_ sender: UIButton) {
        let name = UsernameTextField!.text!.lowercased()
        let finalname = name.trimmingCharacters(in: CharacterSet.whitespaces)
        let password = PasswordTextField.text!
        
        if finalname.isEmpty || password.isEmpty {
            self.view.endEditing(true)
            
            let alertView = SCLAlertView()
            alertView.showError("Caution", subTitle: "one of field is empty!")
            
        }else {
            self.view.endEditing(true)
            authService.signIn(finalname, password: password)
            
        }
    }
    
    
    @IBAction func onSignButtonPressed(_ sender: UIButton) {
        let signVC = storyboard?.instantiateViewController(withIdentifier: "SignVC")
        self.present(signVC!, animated: true, completion: nil)
        self.view.endEditing(true)
    }
    
    @IBOutlet var loginView: UIView!

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        UsernameTextField.resignFirstResponder()
        PasswordTextField.resignFirstResponder()
        return true
    }
    
    func dismissKeyboard(_ gesture: UIGestureRecognizer){
        self.view.endEditing(true)
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
