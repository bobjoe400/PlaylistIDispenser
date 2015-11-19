//
//  PlaylistTableViewController.swift
//  PlaylistDispenser
//
//  Created by Student 2 on 11/18/15.
//  Copyright © 2015 Student 2. All rights reserved.
//

import UIKit

class PlaylistTableViewController: UITableViewController {

    var playlist_data: JSON?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(playlist_data)
        //print(playlist_data)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return playlist_data!["tracks"].count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if playlist_data!["tracks"][indexPath.row]["track"] == nil {
            
            return 0
        }
        return 52
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell :SongTableViewCell = tableView.dequeueReusableCellWithIdentifier("songCell") as! SongTableViewCell
        //print(playlist_data)
        if playlist_data!["tracks"][indexPath.row]["track"] == nil {
            cell.hidden = true
        }
        let selected_track = playlist_data!["tracks"][indexPath.row]["track"]
        cell.sTitle.text = selected_track["title"].stringValue
        cell.aTitle.text = selected_track["artist"].stringValue
        cell.sLength.text = stringFromTimeInterval(NSTimeInterval(selected_track["durationMillis"].doubleValue)) as String
        //print(selected_track)
        return cell;
    }
    
    func stringFromTimeInterval(interval:NSTimeInterval) -> NSString {
        
        let ti = NSInteger(interval)
        
        let seconds = ti/1000 % 60
        let minutes = ((ti/1000)/60) % 60
        
        return NSString(format: "%0.2d:%0.2d",minutes,seconds)
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
    //override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
   

    //}
}
