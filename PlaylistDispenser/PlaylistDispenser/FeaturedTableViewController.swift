//
//  FeaturedTableViewController.swift
//  PlaylistDispenser
//
//  Created by Student 2 on 11/18/15.
//  Copyright © 2015 Student 2. All rights reserved.
//

import UIKit
import Parse
class FeaturedTableViewController: UITableViewController {
    
    var featuredPlaylists = [JSON]()
    var imgA = [UIImage]()
    
    func downloadPlaylistInfo(){
        var jsonData: JSON?
        var urls = [String]()
        let featuredQuery = PFQuery(className: "featuredPlaylistsUrls")
        featuredQuery.findObjectsInBackgroundWithBlock{
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            for object in objects!{
                urls.append(String(object["url"]))
            }
            print(urls)
            var i = 0
            while i < urls.count{
                if let url = NSURL(string: String(urls[i])) {
                    let session = NSURLSession.sharedSession()
                    let download = session.dataTaskWithURL(url) {
                        (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                        jsonData = JSON(data: data!)
                        if self.featuredPlaylists.contains(jsonData!){
                            dispatch_async(dispatch_get_main_queue()){
                                self.tableView.reloadData()
                            }
                            i++
                        }else{
                            self.featuredPlaylists.append(jsonData!)
                            var usl = NSURL(string: "")
                            var j = 0
                            while usl == NSURL(string: ""){
                                usl = NSURL(string: jsonData!["tracks"][j]["track"]["albumArtRef"][0]["url"].stringValue)!
                                j++
                            }
                            let dato = NSData(contentsOfURL: usl!)!
                            let image = UIImage(data: dato)
                            self.imgA.append(image!)
                            dispatch_async(dispatch_get_main_queue()){
                                self.tableView.reloadData()
                            }
                        }
                        jsonData = nil
                    }
                    download.resume()
                }
                i++
            }
        }
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        downloadPlaylistInfo()
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl!.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl!)

        
    }

    func refresh(sender:AnyObject){
        downloadPlaylistInfo()
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
        return featuredPlaylists.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell:basicInfoTableViewCell = tableView.dequeueReusableCellWithIdentifier("basicInfo", forIndexPath: indexPath) as! basicInfoTableViewCell
        delay(0.1){
                let selected_playlist = self.featuredPlaylists[indexPath.row]
        cell.pUpload.text  = selected_playlist["ownerName"].stringValue
        cell.pTitle.text = selected_playlist["name"].stringValue
        cell.numSons.text = String(selected_playlist["tracks"].count)
        cell.pImage.image = self.imgA[indexPath.row]
        }
        return cell;
    }
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
            let data = featuredPlaylists[tableView.indexPathForSelectedRow!.row]
            dest.playlist_data = data
            dest.pName = data["name"].stringValue
            dest.num = String(data["tracks"].count)
            dest.image = self.imgA[tableView.indexPathForSelectedRow!.row]
            dest.title = data["name"].stringValue
            dest.uInfo = data["ownerName"].stringValue
        }
    }

    
}
