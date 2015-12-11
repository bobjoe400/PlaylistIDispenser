//
//  ImportFromGPlayTableViewController.swift
//  PlaylistDispenser
//
//  Created by Student 2 on 12/2/15.
//  Copyright © 2015 Student 2. All rights reserved.
//

import UIKit
import Parse
class ImportFromGPlayTableViewController: UITableViewController {
    
    var playlists: JSON?
    var bestPlaylist: [JSON]?
    var imgA: [UIImage?]?
    var user: PFObject?
    
    @IBAction func unwindToTable(segue: UIStoryboardSegue) {
        performSegueWithIdentifier("unwindToProfile", sender: nil)
    }
    
    func downloadData(){
        let betterPlaylists = self.playlists!
        var preplaylists = [JSON]()
        var complete = [Bool]()
        var imgB = [UIImage?]()
        for i in betterPlaylists{
            preplaylists.append(nil)
            complete.append(false)
            imgB.append(nil)
        }
        print("finding objects")
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        for (i,obj) in betterPlaylists.enumerate(){
            var json: JSON?
            json = betterPlaylists[i]
            var usl = NSURL(string: "")
            var j = 0
            while usl ==  NSURL(string: "") && j < json!["tracks"].count{
                usl = NSURL(string: json!["tracks"][j]["track"]["albumArtRef"][0]["url"].stringValue)!
                j++
            }
            if let dato = NSData(contentsOfURL: usl!){
                let image = UIImage(data: dato)
                imgB[i] = image!
            }
            preplaylists[i] = json!
            complete[i] = true
            var alldone = true
            for b in complete{
                alldone = alldone && b
            }
            if alldone {
                var imgC = [UIImage?]()
                var feat = [JSON]()
                for j in preplaylists{
                    feat.append(j)
                }
                for j in imgB{
                    if j == nil{
                        imgC.append(nil)
                    }else{
                        imgC.append(j!)
                    }
                }
                self.imgA = imgC
                self.bestPlaylist = preplaylists
                self.tableView.reloadData()
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgA = [UIImage]()
        bestPlaylist = [JSON]()
        downloadData()
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
        if self.playlists!.isEmpty{
            return 0
        }
        return self.playlists!.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Configure the cell...
        let cell:basicInfoTableViewCell = tableView.dequeueReusableCellWithIdentifier("basicInfo", forIndexPath: indexPath) as! basicInfoTableViewCell
        let selected_playlist = self.playlists![indexPath.row]
        cell.pTitle.text = selected_playlist["name"].stringValue
        cell.numSons.text = String(selected_playlist["tracks"].count)
        if self.imgA![indexPath.row] == nil{
            cell.pImage.image = UIImage(named: "noart")
        }else{
            cell.pImage.image = self.imgA![indexPath.row]
        }
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
        if segue.identifier == "importing"{
            let dest = segue.destinationViewController as! importingViewController
            dest.playlists = self.playlists
            dest.playlist = self.playlists![tableView.indexPathForSelectedRow!.row]
            dest.user = self.user

        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
