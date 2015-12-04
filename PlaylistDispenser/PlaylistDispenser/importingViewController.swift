//
//  importingViewController.swift
//  PlaylistDispenser
//
//  Created by Student 2 on 12/3/15.
//  Copyright © 2015 Student 2. All rights reserved.
//

import UIKit
import Parse

class importingViewController: UIViewController {
    
    var playlists: JSON?
    var playlist: JSON?
    var user: PFObject?
    var good = true
    override func viewDidLoad() {
        super.viewDidLoad()
        let new_playlist = PFObject(className: "playlists")
        let query = PFQuery(className: "playlists")
        
        query.findObjectsInBackgroundWithBlock {
            (playlists: [PFObject]?, error: NSError?) -> Void in
            for data in playlists!{
                if String(data["name"]) == String(self.playlist!["name"]){
                    self.good = false
                    print("Already exists")
                }
            }
            if self.good == true{
                new_playlist["name"] = String(self.playlist!["name"])
                new_playlist["user"] = self.user!["username"]
                let playlist_string = String(self.playlist!)
                let data = playlist_string.dataUsingEncoding(NSUTF8StringEncoding)
                let file = PFFile(name: "playlist.json", data: data!)
                new_playlist["gplaydata"] = file
                self.user!.addObject(String(self.playlist!["name"]), forKey:"playlists")
                new_playlist.saveInBackground()
                self.user!.saveInBackground()
            }
            self.performSegueWithIdentifier("backToProfile", sender: nil)
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
        if segue.identifier == "backToPlaylist"{
            let dest = segue.destinationViewController as! ProfileViewController
            dest.userObject = user
            dest.playlist_data = self.playlists
            dest.hasgPlay = true
        }
        
    }


}
