//
//  ProfileViewController.swift
//  PlaylistDispenser
//
//  Created by Student 2 on 11/18/15.
//  Copyright © 2015 Student 2. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    var Uname: String?
    var image: UIImage?
    var playlist_data: JSON?
    var hasgPlay: Bool?
    var userObject: PFObject?
    var ip: String?
    
    
    @IBOutlet weak var gButton: UIButton!
    @IBOutlet weak var uName: UILabel!
    @IBOutlet weak var uImage: UIImageView!
    @IBAction func setButt(sender: AnyObject){
        
    }
    @IBOutlet weak var importButt: UIButton!
    
    @IBAction func unwindToProfile(segue: UIStoryboardSegue) {
        self.childViewControllers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uName.text = String(userObject!["username"])
        let userImageFile = userObject!["profilePicture"] as! PFFile
        userImageFile.getDataInBackgroundWithBlock{
            (imageData: NSData?, error: NSError?) -> Void in
            if error == nil{
                if let imageData = imageData{
                    self.uImage.image = UIImage(data: imageData)
                }
            }
        }
        let gplay = self.userObject!["gplay"] as! Bool
        if !gplay{
            self.importButt.hidden = true
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
        if "embedSegue" == segue.identifier{
            print("gothere")
            let vc = segue.destinationViewController as! ProfileTableViewController
            vc.userData = self.userObject
            vc.ip = self.ip
        }
        if "importFromGPlay" == segue.identifier{
            let vc = segue.destinationViewController as! ImportFromGPlayTableViewController
            vc.playlists = self.playlist_data!
            vc.user = self.userObject
        }
        
        if segue.identifier == "profileSettingsSegue" {
            let vc = segue.destinationViewController as! SettingsViewController
            vc.userData = self.userObject!
        }
    }


}
