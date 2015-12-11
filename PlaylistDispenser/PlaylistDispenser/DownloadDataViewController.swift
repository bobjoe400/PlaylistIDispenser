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
    var userObject: PFObject?
    var ip: String?
    var userPlaylist: [PFObject]?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var indicatorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        let loginQuery = PFQuery(className: "users")
        let ip = self.ip!
        loginQuery.findObjectsInBackgroundWithBlock{
            (objects:[PFObject]?, error: NSError?) -> Void in
            for object in objects!{
                if String(object["username"]) == self.username!{
                    if object["gplay"] as! Bool == true{
                        self.indicatorLabel.text = "Downloading Google Play Library Data..."
                        let url = NSURL(string: "http://" + ip + "/cgi-bin/download_playlists.py?email=" + String(object["email"]) + "&password=" + String(object["gplayPass"]))
                        let session = NSURLSession.sharedSession()
                        let download = session.dataTaskWithURL(url!) {
                            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                            if data != nil{
                                self.gplayData = JSON(data: data!)
                                self.userObject = object
                                self.performSegueWithIdentifier("moveToApp", sender: nil)
                            }else{
                                let alert = UIAlertView()
                                alert.addButtonWithTitle("Error")
                                alert.message = "Could not load Google Play Data"
                                alert.show()
                                self.performSegueWithIdentifier("unwindToLogin", sender: nil)
                            }
                        }
                        download.resume()
                    }else{
                        self.userObject = object
                        self.performSegueWithIdentifier("moveToApp", sender: nil)
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
            let navi2 = TBC.viewControllers![0] as! UINavigationController
            let featured = navi2.viewControllers[0] as! FeaturedTableViewController
            let navi3 = TBC.viewControllers![1] as! UINavigationController
            let search = navi3.viewControllers[0] as! SearchViewController
            featured.userData = self.userObject
            featured.ip = self.ip
            profile.userObject = self.userObject
            profile.playlist_data = gplayData
            profile.ip = self.ip
            search.userData = self.userObject
            search.ip = self.ip
//            TBC.tabBar.items![0].image = UIImage(named: "News-512")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
//            TBC.tabBar.items![1].image = UIImage(named: "Share-512 copy")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
//            TBC.tabBar.items![2].image = UIImage(named: "User Male-512 copy 4")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        }
    }


}
