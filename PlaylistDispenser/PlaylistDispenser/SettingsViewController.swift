//
//  SettingsViewController.swift
//  PlaylistDispenser
//
//  Created by Student 2 on 12/3/15.
//  Copyright © 2015 Student 2. All rights reserved.
//

import UIKit
import Parse

class SettingsViewController: UITableViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var userData: PFObject?
    
    @IBAction func saveButtonClicked(sender: AnyObject) {
        let username = usernameTextField.text
        let password = passwordTextField.text
        if username == "" || password == "" {
            let alert = UIAlertView()
            alert.title = "Error"
            alert.message = "Error: Blank Field"
            alert.addButtonWithTitle("OK")
            alert.show()
        } else {
            let obj = userData!
            obj["gplay"] = true
            obj["gplayPass"] = password
            obj["email"] = username
            obj.saveInBackground()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let obj = userData!
        print(self.usernameTextField.text = String(obj["email"]))
        self.usernameTextField.text = String(obj["email"])
        self.passwordTextField.text = String(obj["gplayPass"])
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    //override func didReceiveMemoryWarning() {
        //super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    //}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
