//
//  SignUpViewController.swift
//  Schooler
//
//  Created by Huang Zhou on 2017-03-17.
//  Copyright © 2017 Huang Zhou. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate{
    
    
    @IBAction func onLoginButtonPressed(_ sender: UIButton) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        self.present(loginVC!, animated: true, completion: nil)

    }
    
    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var rePasswordTextField: UITextField!
    @IBOutlet weak var schoolTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    
    var authService = AuthenticationService()
    
    
    @IBAction func signUpButton(_ sender: UIButton) {
        let email = emailTextField.text!.lowercased()
        let finalEmail = email.trimmingCharacters(in: CharacterSet.whitespaces)
        let username = UsernameTextField.text!
        let password = PasswordTextField.text!
        let repassword = rePasswordTextField.text!
        let school = schoolTextField.text!
        
        if finalEmail.isEmpty || username.isEmpty || password.isEmpty || repassword.isEmpty || school.isEmpty{
            self.view.endEditing(true)
            
            let alertView = SCLAlertView()
            alertView.showError("Caution", subTitle: "Missing information, Please try again")
        }
        else if password != repassword{
            self.view.endEditing(true)
            let alertView = SCLAlertView()
            alertView.showError("Caution", subTitle: "Password not matched, please try again")
        }
        else {
            self.view.endEditing(true)
            
            authService.signUp(finalEmail, username: username, password: password, repassword: repassword, school: school)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        UsernameTextField.resignFirstResponder()
        PasswordTextField.resignFirstResponder()
        rePasswordTextField.resignFirstResponder()
        schoolTextField.resignFirstResponder()
        return true
    }
    
    func dismissKeyboard(_ gesture: UIGestureRecognizer){
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        UsernameTextField.delegate = self
        PasswordTextField.delegate = self
        emailTextField.delegate = self
        rePasswordTextField.delegate = self
        schoolTextField.delegate = self
        
        
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
