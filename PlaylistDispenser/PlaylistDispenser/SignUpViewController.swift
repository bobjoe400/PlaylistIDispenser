//
//  SignUpViewController.swift
//  PlaylistDispenser
//
//  Created by Student 2 on 11/19/15.
//  Copyright © 2015 Student 2. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func signUpButtonClicked(sender: AnyObject) {
        signupCheck()
    }
    
    func signupCheck(){
        if self.passwordTextField.text != self.confirmPasswordTextField.text {
            let alert = UIAlertView()
            alert.title = "Error"
            alert.message = "Passwords entered do not match"
            alert.addButtonWithTitle("Try again")
            alert.show()
            self.passwordTextField.text = ""
            self.confirmPasswordTextField.text = ""
            self.passwordTextField.becomeFirstResponder()
        } else if (self.passwordTextField.text=="") || (self.confirmPasswordTextField.text=="") || (self.usernameTextField.text=="") || (self.emailTextField.text=="") {
            let alert = UIAlertView()
            alert.title = "Error"
            alert.message = "Error: Blank Field"
            alert.addButtonWithTitle("Try again")
            alert.show()
        } else {
            let email = emailTextField.text
            let username = usernameTextField.text
            let password = passwordTextField.text
            let signUpData = PFObject(className: "users")
            signUpData["username"] = username
            signUpData["password"] = password
            signUpData["email"] = email
            signUpData["gplay"] = false
            signUpData.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                print(signUpData)
            }
            performSegueWithIdentifier("segueSignUptoLogin", sender: nil)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == emailTextField{
            self.usernameTextField.becomeFirstResponder()
        }else if textField == usernameTextField{
            self.passwordTextField.becomeFirstResponder()
        }else if textField == passwordTextField{
            self.confirmPasswordTextField.becomeFirstResponder()
        }else if textField == confirmPasswordTextField{
            textField.resignFirstResponder()
            signupCheck()
        }
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
