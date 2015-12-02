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
    var userData: String?
    var found = false
    var isCorrectPassword = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginButtonClicked(sender: AnyObject) {
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
                        self.performSegueWithIdentifier("downloadData", sender: self)
                    }
                }else{
                    let alert = UIAlertView()
                    alert.title = "Error"
                    alert.message = "Wrong username or password"
                    alert.addButtonWithTitle("Try again")
                    alert.show()
                }
            }

        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "downloadData"{
            let dest = segue.destinationViewController as! DownloadDataViewController
            dest.username = self.userData
            
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

    }
    

}
