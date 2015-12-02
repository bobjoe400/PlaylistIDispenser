//
//  DownloadDataViewController.swift
//  PlaylistDispenser
//
//  Created by Student 2 on 12/1/15.
//  Copyright © 2015 Student 2. All rights reserved.
//

import UIKit
import Parse

class DownloadDataViewController: UIViewController {
    var username: String?
    var gplayData: JSON?
    var userObj: PFObject?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var indicatorLabel: UILabel!
    let ip = "129.65.92.72"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        let loginQuery = PFQuery(className: "users")
        loginQuery.findObjectsInBackgroundWithBlock{
            (objects:[PFObject]?, error: NSError?) -> Void in
            print("Got here")
            for object in objects!{
                if String(object["username"]) == self.username!{
                    if object["gplay"] as! Bool == true{
                        self.indicatorLabel.text = "Downloading Google Play Library Data..."
                        let url = NSURL(string: "http://" + self.ip + "/cgi-bin/download_playlists.py?email=" + String(object["email"]) + "&password=" + String(object["gplayPass"]))
                        print(url!)
                        let session = NSURLSession.sharedSession()
                        let download = session.dataTaskWithURL(url!) {
                            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                            self.gplayData = JSON(data: data!)
                            self.userObj = object
                            self.performSegueWithIdentifier("moveToApp", sender: nil)
                        }
                       download.resume()
                    }
                }
            }
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "moveToApp"{
            let TBC = segue.destinationViewController as! UITabBarController
            let navi = TBC.viewControllers![2] as! UINavigationController
            let profile = navi.viewControllers[0] as! ProfileViewController
            profile.Uname = username
            profile.playlist_data = gplayData
        }
    }


}
