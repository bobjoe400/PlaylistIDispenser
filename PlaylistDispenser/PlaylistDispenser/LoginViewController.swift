//
//  LoginViewController.swift
//  PlaylistDispenser
//
//  Created by Student 2 on 11/19/15.
//  Copyright © 2015 Student 2. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var username = ""
    var password = ""
    var found = false
    var isCorrectPassword = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginButtonClicked(sender: AnyObject) {
        username = usernameTextField.text!
        password = passwordTextField.text!
        let loginQuery = PFQuery(className: "users")
        loginQuery.findObjectsInBackgroundWithBlock{
            (objects:[PFObject]?, error: NSError?) -> Void in
            for object in objects! {
                let correctUserName:String = object["username"] as! String
                let correctPassword:String = object["password"] as! String
                if correctUserName.lowercaseString == self.username.lowercaseString {
                    self.found = true
                    if correctPassword == self.password {
                        self.isCorrectPassword = true
                        print(self.found)
                        print(self.isCorrectPassword)
                        self.performSegueWithIdentifier("swag", sender: nil)
                    }
                }
            }
            if !self.found || !self.isCorrectPassword {
                let alert = UIAlertView()
                alert.title = "Error"
                alert.message = "Wrong username or password"
                alert.addButtonWithTitle("Try again")
                alert.show()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

    }*/
    

}
