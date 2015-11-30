//
//  SignUpViewController.swift
//  PlaylistDispenser
//
//  Created by Student 2 on 11/19/15.
//  Copyright © 2015 Student 2. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func signUpButtonClicked(sender: AnyObject) {
        if self.passwordTextField.text != self.confirmPasswordTextField.text {
            let alert = UIAlertView()
            alert.title = "Error"
            alert.message = "Passwords entered do not match"
            alert.addButtonWithTitle("Try again")
            alert.show()
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
