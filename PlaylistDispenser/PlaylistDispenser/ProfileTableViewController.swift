//
//  ProfileTableViewController.swift
//  PlaylistDispenser
//
//  Created by Student 2 on 11/18/15.
//  Copyright © 2015 Student 2. All rights reserved.
//

import UIKit
import Parse

class ProfileTableViewController: UITableViewController {

    var playlists: [JSON]?
    var imgA: [UIImage]?
    var userData: PFObject?
    
    func downloadData(){
        let userQuery = PFQuery(className: "users")
        userQuery.whereKey("username", equalTo: String(userData!["username"]))
        userQuery.findObjectsInBackgroundWithBlock{
            (objects: [PFObject]?, error: NSError?) -> Void in
            let data = objects![0]
            self.userData!["playlists"] = data["playlists"]
            self.tableView.reloadData()
        }
        var preplaylists = [JSON]()
        let playlistsQuery = PFQuery(className: "playlists")
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        playlistsQuery.whereKey("user", equalTo: String(userData!["username"]))
        playlistsQuery.findObjectsInBackgroundWithBlock{
            (objects: [PFObject]?, error: NSError?) -> Void in
            var complete = [Bool]()
            var imgB = [UIImage?]()
            for i in objects!{
                complete.append(false)
                imgB.append(nil)
            }
            print("finding objects")
            for (i,obj) in objects!.enumerate(){
                let file = obj["gplaydata"] as! PFFile
                var json: JSON?
                file.getDataInBackgroundWithBlock{
                    (data: NSData?, error: NSError?) -> Void in
                    json = JSON(data: data!)
                    //print(json)
                    var usl = NSURL(string: "")
                    var j = 0
                    while usl == NSURL(string: ""){
                        usl = NSURL(string: json!["tracks"][j]["track"]["albumArtRef"][0]["url"].stringValue)!
                        j++
                    }
                    let dato = NSData(contentsOfURL: usl!)!
                    let image = UIImage(data: dato)
                    imgB[i] = image!
                    preplaylists.append(json!)
                    complete[i] = true
                    var alldone = true
                    for b in complete{
                        //print(b)
                        alldone = alldone && b
                        //print(alldone)
                    }
                    if alldone {
                        print("dispatching")
                        dispatch_async(dispatch_get_main_queue()){
                            self.playlists = preplaylists
                            var imgC = [UIImage]()
                            //var feat = [JSON]()
                            for j in imgB{
                                imgC.append(j!)
                            }
                            self.imgA = imgC
                            self.tableView.reloadData()
                            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                        }
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.playlists = [JSON]()
        //print("gothere")
        downloadData()
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.attributedTitle = NSAttributedString(string: "Pull to Refesh")
        self.refreshControl!.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl!)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    func refresh(sender:AnyObject){
        downloadData()
        self.refreshControl!.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if playlists!.isEmpty{
            return 0
        }
        return self.playlists!.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...
        let cell:basicInfoTableViewCell = tableView.dequeueReusableCellWithIdentifier("basicInfo", forIndexPath: indexPath) as! basicInfoTableViewCell
        let selected_playlist = self.playlists![indexPath.row]
        cell.pTitle.text = selected_playlist["name"].stringValue
        cell.numSons.text = String(selected_playlist["tracks"].count)
        cell.pImage.image = self.imgA![indexPath.row]
       return cell;
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if "toPlaylist" == segue.identifier{
            let dest = segue.destinationViewController as! PlaylistViewController
            let data = playlists![tableView.indexPathForSelectedRow!.row]
            dest.playlist_data = data
            dest.pName = data["name"].stringValue
            dest.num = String(data["tracks"].count)
            dest.image = self.imgA![tableView.indexPathForSelectedRow!.row]
            dest.title = data["name"].stringValue
            dest.uInfo = data["ownerName"].stringValue
        }
        
    }


}
