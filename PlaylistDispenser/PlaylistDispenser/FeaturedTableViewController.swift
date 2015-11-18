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
    
    var jsonData = [JSON]()
    
    func downloadPlaylistInfo(){
        var urls = [String]()
        let featuredQuery = PFQuery(className: "featuredPlaylistsUrls")
        featuredQuery.findObjectsInBackgroundWithBlock{
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            for object in objects!{
                urls.append(String(object["url"]))
            }
            
            var i = 0
            while i < urls.count{
                if let url = NSURL(string: urls[i]) {
                    let session = NSURLSession.sharedSession()
                    let download = session.dataTaskWithURL(url) {
                        (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                        self.jsonData.append(JSON(data: data!))
                        
                    }
                    download.resume()
                }
                i++
                print("")
                print(self.jsonData)
                print("")
            }
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        downloadPlaylistInfo()
    

        
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
        return 3
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell:basicInfoTableViewCell = tableView.dequeueReusableCellWithIdentifier("basicInfo", forIndexPath: indexPath) as! basicInfoTableViewCell
        
        cell.pUpload.text  = "swag"
        cell.pTitle.text = "9gag"
        cell.numSons.text = "42000"
        cell.pImage.image = UIImage(named: "xjh15")
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
