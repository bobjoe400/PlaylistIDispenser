//
//  ExportViewController.swift
//  PlaylistDispenser
//
//  Created by Student 2 on 12/4/15.
//  Copyright © 2015 Student 2. All rights reserved.
//

import UIKit

class ExportViewController: UIViewController {

    var whereFrom: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if whereFrom == "search"{
            self.performSegueWithIdentifier("unwindToSearch", sender: nil)
        }else if whereFrom == "featured"{
            self.performSegueWithIdentifier("unwindToFeatured", sender: nil)
        }
        // Do any additional setup after loading the view.
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
