//
//  LoginViewController.swift
//  PlaylistDispenser
//
//  Created by Student 2 on 11/19/15.
//  Copyright © 2015 Student 2. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var userData: String?
    var found = false
    var isCorrectPassword = false
    var userObject: PFObject?

    @IBAction func loginButtonClicked(sender: AnyObject) {
        loginCheck()
    }
    
    func loginCheck(){
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        
        
        let loginQuery = PFQuery(className: "users")
        loginQuery.findObjectsInBackgroundWithBlock{
            (objects:[PFObject]?, error: NSError?) -> Void in
            for object in objects! {
                let foundUserName = String(object["username"])
                let foundPassword = String(object["password"])
                if foundUserName.lowercaseString == username.lowercaseString {
                    if foundPassword == password  {
                        self.userData = foundUserName
                        self.userObject = object
                        self.performSegueWithIdentifier("downloadData", sender: self)
                    }
                    else{
                        let alert = UIAlertView()
                        alert.title = "Error"
                        alert.message = "Wrong username or password"
                        alert.addButtonWithTitle("Try again")
                        alert.show()
                        self.usernameTextField.becomeFirstResponder()
                    }
                }
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.usernameTextField{
            self.passwordTextField.becomeFirstResponder()
        }else if textField == self.passwordTextField{
            textField.resignFirstResponder()
            loginCheck()
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.clearsOnBeginEditing = true
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "downloadData"{
            let dest = segue.destinationViewController as! DownloadDataViewController
            dest.username = self.userData
            dest.userObject = self.userObject
            dest.ip = "129.65.92.142"
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

    }
    

}
