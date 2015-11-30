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
    
    @IBOutlet weak var gButton: UIButton!
    @IBOutlet weak var uName: UILabel!
    @IBOutlet weak var uImage: UIImageView!
    @IBAction func setButt(sender: AnyObject){
        
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
        let uInfo = PFQuery(className: "users")
        uInfo.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            let object = objects![0]
            self.hasgPlay = object["gplay"] as? Bool
            if self.hasgPlay == true{
                self.gButton.hidden = true
            }
            self.uName.text = object["username"] as? String
            
            //            let bool = objects![0]["gplay"] as! Bool
//            print(bool)
//            if bool {
//                self.gButton.hidden = true
//            }
        }
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
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        //if "embedSegue" == segue.identifier{
          //  let detailScene = segue.destinationViewController as! FeaturedTableViewController
            //detailScene.playlist_data = self.playlist_data
        //}
    }*/


}
