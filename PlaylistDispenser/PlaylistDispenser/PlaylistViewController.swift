//
//  PlaylistViewController.swift
//  PlaylistDispenser
//
//  Created by Student 2 on 11/18/15.
//  Copyright © 2015 Student 2. All rights reserved.
//

import UIKit
import CoreData
import Parse
class PlaylistViewController: UIViewController {
    var userData: PFObject?
    weak var embedvc: PlaylistTableViewController?
    var playlist_data: JSON?
    var pName: String?
    var num: String?
    var image: UIImage?
    var uInfo: String?
    var ip: String?
    var whereFrom: String?
    //var managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var check: Bool?
    
    @IBAction func exportPlaylist(sender: AnyObject) {
        self.performSegueWithIdentifier("toExport", sender: nil)
    }
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
    }
    @IBOutlet weak var uName: UILabel!
    @IBOutlet weak var pImage: UIImageView!
    @IBOutlet weak var pTitle: UILabel!
    @IBOutlet weak var numSongs: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBAction func addButton(sender: AnyObject) {
        if self.check != nil{
            if self.check == true{
                addButton.setImage(UIImage(named: "Plus-512.png"), forState: UIControlState.Normal)
                self.check = false
            }else{
                addButton.setImage(UIImage(named: "Checked-512.png"), forState: UIControlState.Normal)
                self.check = true
            }
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.pImage.image = self.image!
        self.pTitle.text = self.pName!
        self.numSongs.text = self.num!
        let checkArray = self.userData!["playlists"] as! [String]
        print(checkArray)
        if checkArray.contains(self.playlist_data!["name"].stringValue){
            self.check = false
        }else{
            self.check = true
        }
        self.uName.text = self.uInfo!
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
        if segue.identifier == "embedSegue"{
            let detailScene = segue.destinationViewController as! PlaylistTableViewController
            detailScene.playlist_data = self.playlist_data
        }
        if segue.identifier == "toExport"{
            let dest = segue.destinationViewController as! ExportViewController
            dest.playlistData = self.playlist_data
            dest.userData = self.userData
            dest.whereFrom = self.whereFrom
            dest.ip = self.ip
        }
    }
}
