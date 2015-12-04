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
    
    
    @IBOutlet weak var gButton: UIButton!
    @IBOutlet weak var uName: UILabel!
    @IBOutlet weak var uImage: UIImageView!
    @IBAction func setButt(sender: AnyObject){
        
    }
    
    @IBAction func unwindToProfile(segue: UIStoryboardSegue) {
        self.childViewControllers
    }
    
//    func delay(delay:Double, closure:()->()) {
//        dispatch_after(
//            dispatch_time(
//                DISPATCH_TIME_NOW,
//                Int64(delay * Double(NSEC_PER_SEC))
//            ),
//            dispatch_get_main_queue(), closure)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.childViewControllers)
        print(userObject)
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
        
        //print(playlist_data)
//        delay(0.5){
//            let loginformVC = self.childViewControllers.last as! FeaturedTableViewController
//            let playlist_data = loginformVC.featuredPlaylists[0] as JSON
//            self.uName.text = playlist_data["ownerName"].stringValue
//            self.uCity.text = "San Luis Obisbo, CA"
//            var usl = NSURL(string: "")
//            var j = 0
//            while usl == NSURL(string: ""){
//                usl = NSURL(string: playlist_data["tracks"][j]["track"]["albumArtRef"][0]["url"].stringValue)!
//                j++
//            }
//            let dato = NSData(contentsOfURL: usl!)!
//            self.uImage.image = UIImage(data: dato)
//        }
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
        //if "embedSegue" == segue.identifier{
          //  let detailScene = segue.destinationViewController as! FeaturedTableViewController
            //detailScene.playlist_data = self.playlist_data
        //}
        if "embedSegue" == segue.identifier{
            print("gothere")
            let vc = segue.destinationViewController as! ProfileTableViewController
            vc.userData = self.userObject
        }
        if "importFromGPlay" == segue.identifier{
            let vc = segue.destinationViewController as! ImportFromGPlayTableViewController
            vc.playlists = playlist_data
            vc.user = self.userObject
        }
        
        if (segue.identifier == "profileSettingsSegue") {
            let vc = segue.destinationViewController as! SettingsViewController
            vc.userData = self.userObject!
        }
    }


}
