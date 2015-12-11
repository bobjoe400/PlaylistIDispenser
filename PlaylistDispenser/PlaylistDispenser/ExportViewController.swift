//
//  ExportViewController.swift
//  PlaylistDispenser
//
//  Created by Student 2 on 12/4/15.
//  Copyright © 2015 Student 2. All rights reserved.
//

import UIKit
import Parse
class ExportViewController: UIViewController {
    var playlistData: JSON?
    var userData: PFObject?
    var whereFrom: String?
    var ip: String?
    @IBOutlet weak var pName: UILabel!
    @IBOutlet weak var pSongs: UILabel!
    
    @IBAction func backButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func export(){
        let playlist_name = String(playlistData!["name"])
        let numTracks = playlistData!["tracks"].count
        let tracks = playlistData!["tracks"]
        let email = String(userData!["email"])
        let password = String(userData!["gplayPass"])
        var ids: [String] = []
        var i = 0

        while i < numTracks{
            let track = tracks[i]["trackId"].stringValue
            if track.characters.first == "T"{
                ids.append(String(tracks[i]["trackId"]))
                i = i + 1
            }
        }
        
        var shorturl = "http://" + self.ip!
        var addurl = shorturl
        shorturl = shorturl + "/cgi-bin/create_new_playlist.py?email="
        shorturl = shorturl + email + "&password=" + password
        addurl = addurl + "/cgi-bin/add_to_playlist.py?"
        addurl = addurl + "email=" + email
        addurl = addurl + "&password=" + password
        addurl = addurl + "&playlist_id="
        
        var create_playlist_url_string = shorturl + "&title=" + playlist_name
        
        create_playlist_url_string = create_playlist_url_string.stringByReplacingOccurrencesOfString(" ", withString: "%20", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        let create_playlist_url = NSURL(string: create_playlist_url_string)
        
        var good = false
        var comeback = ""
        if let data = NSData(contentsOfURL: create_playlist_url!){
            comeback = NSString(data: data, encoding: NSUTF8StringEncoding) as! String
            good = true
        }
        
        i = 0
        while i < ids.count{
            let id = ids[i]
            if good == true{
                var url_string = (addurl + comeback + "&id=" + id)
                url_string = url_string.stringByReplacingOccurrencesOfString("\n", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                let add_playlist_url = NSURL(string: url_string)
                if let data = NSData(contentsOfURL: add_playlist_url!){
                    var response = NSString(data: data, encoding: NSUTF8StringEncoding) as! String
                    response = response.stringByReplacingOccurrencesOfString("\n", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                    good = false
                    if response == "success"{
                        good = true
                        i++
                    }else if response == "failure"{
                        good = true
                        i++
                    }
                }
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pName.text = playlistData!["name"].stringValue
        pSongs.text = String(playlistData!["tracks"].count)
        export()
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
