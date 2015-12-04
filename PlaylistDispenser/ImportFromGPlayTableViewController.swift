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
    //var betterPlaylists: [JSON]?
    var bestPlaylist: [JSON]?
    var imgA: [UIImage]?
    var user: PFObject?
    
    @IBAction func unwindToTable(segue: UIStoryboardSegue) {
        performSegueWithIdentifier("unwindToProfile", sender: nil)
    }
    
    func downloadData(){
        let betterPlaylists = self.playlists!.array
        var preplaylists = [JSON]()
        var complete = [Bool]()
        var imgB = [UIImage?]()
        for i in betterPlaylists!{
            if i["name"] == "Niko's playlist"{
                complete.append(true)
                imgB.append(nil)
                continue
            }
            complete.append(false)
            imgB.append(nil)
        }
        print("finding objects")
        for (i,obj) in betterPlaylists!.enumerate(){
            if obj["name"] == "Niko's playlist" || obj["name"] == " "{
                continue
            }
            var json: JSON?
            json = obj
            //print(json
            var usl = NSURL(string: "")
            var j = 0
            var url = ""
            var length = 0
            print (obj["name"])
            var urlfound = false
            while j < json!["tracks"].count && !urlfound{
                //print(j)
                urlfound = false
                url = json!["tracks"][j]["track"]["albumArtRef"][0]["url"].stringValue
                url = url.stringByReplacingOccurrencesOfString("\\", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                length = url.characters.count
                if let checkedUrl = NSURL(string: url) {
                    //imageURL.contentMode = .ScaleAspectFit
                    downloadImage(checkedUrl)
                }
                if length != 0{
                    urlfound = true
                }
                //print(length)
                j++
            }
            print(url)
//            usl = NSURL(string: url)!
//            let dato = NSData(contentsOfURL: usl!)!
//            let image = UIImage(data: dato)
//            print(image)
//            imgB[i] = image!
            //print(json!)
            preplaylists.append(json!)
            //print(preplaylists)
            print(complete[i])
            complete[i] = true
            print(complete[i])
            var alldone = true
            print(complete)
            //complete[8] = true
            for b in complete{
                //print(b)
                alldone = alldone && b
            }
                //print(alldon
            print(alldone)
            if alldone {
                print(imgB)
                print("dispatching")
                dispatch_async(dispatch_get_main_queue()){
                    //self.bestPlaylist = preplaylists
                    var imgC = [UIImage]()
                    var feat = [JSON]()
                    for j in preplaylists{
                        feat.append(j)
                    }
                    //for j in imgB{
                      //  imgC.append(j!)
                   // }
                    self.bestPlaylist = feat
                    //self.imgA = imgC
                    self.tableView.reloadData()
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                }
            }
        }
    }

    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
    func downloadImage(url: NSURL) -> Bool{
        //print("Started downloading \"\(url.URLByDeletingPathExtension!.lastPathComponent!)\".")
        getDataFromUrl(url) { (data, response, error)  in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                print("Finished downloading \"\(url.URLByDeletingPathExtension!.lastPathComponent!)\".")
                self.imgA!.append(UIImage(data: data)!)
            }
            //return true
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgA = [UIImage]()
        //betterPlaylists = playlists!.arrayValue
        bestPlaylist = [JSON]()
        //print(betterPlaylists)
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
        if bestPlaylist!.isEmpty{
            return 0
        }
        return self.bestPlaylist!.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Configure the cell...
        let cell:basicInfoTableViewCell = tableView.dequeueReusableCellWithIdentifier("basicInfo", forIndexPath: indexPath) as! basicInfoTableViewCell
        let selected_playlist = self.bestPlaylist![indexPath.row]
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
