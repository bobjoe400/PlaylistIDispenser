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
    
    var jsonData: JSON?
    var featuredPlaylists = [JSON]()
    var imgA = [UIImage]() //= [UIImage,UIImage,UIImage,UIImage,UIImage]
    
    func downloadPlaylistInfo(){
        self.jsonData = []
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
                        self.jsonData! = JSON(data: data!)
                        self.featuredPlaylists.append(self.jsonData!)
                        var usl = NSURL(string: "")
                        var j = 0
                        while usl == NSURL(string: ""){
                            usl = NSURL(string: self.jsonData!["tracks"][j]["track"]["albumArtRef"][0]["url"].stringValue)!
                            j++
                        }
                        let dato = NSData(contentsOfURL: usl!)!
                        let image = UIImage(data: dato)
                        self.imgA.append(image!)
                        self.tableView.reloadData()
                    }
                    download.resume()
                }
                i++
                /*if i == urls.count{
                    run = true
                }*/
            }
            //print(self.jsonData)
        }
        
    }
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
    func downloadImage(urls: String){
        let url = NSURL(string: urls)
        let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
        //imageURL.image = UIImage(data: data!)
        self.imgA.append(UIImage(data: data!)!)
    }
    
    func downloadImage(){
        var image = UIImage()
                //print("Started downloading \"\(url.URLByDeletingPathExtension!.lastPathComponent!)\".")
        if self.featuredPlaylists.count == 5{
            for json in self.featuredPlaylists{
                getDataFromUrl(NSURL(string: json["tracks"][0]["track"]["albumArtRef"][0]["url"].stringValue)!) { (data, response, error)  in
                    dispatch_async(dispatch_get_main_queue()) { () -> Void in
                        let url = NSURL(string: json["tracks"][0]["track"]["albumArtRef"][0]["url"].stringValue)!
                        guard let data = data where error == nil else { return }
                        print("Finished downloading \"\(url.URLByDeletingPathExtension!.lastPathComponent!)\".")
                        image = UIImage(data: data)!
                        self.imgA.append(image)
                        //self.tableView.reloadData()
                    }
                }
            }
            self.tableView.reloadData()
        }
        //self.tableView.reloadData()
    }
    
    
    func testDowload(){
        if let url = NSURL(string: "https://users.csc.calpoly.edu/~lmatusia/0.json") {
            let session = NSURLSession.sharedSession()
            let download = session.dataTaskWithURL(url) {
                (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                print(data!)
                let jsonData = JSON(data: data!)
                print(jsonData["tracks"].count)
            }
            download.resume()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //testDowload()
        //self.jsonData = []
        downloadPlaylistInfo()
        /*repeat{
            downloadImage()
        }while self.featuredPlaylists.count != 5*/
        //downloadImage()
        //print(self.jsonData)

        
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
        let selected_playlist = featuredPlaylists[indexPath.row]
        cell.pUpload.text  = selected_playlist["ownerName"].stringValue
        cell.pTitle.text = selected_playlist["name"].stringValue
        cell.numSons.text = String(selected_playlist["tracks"].count)
        //cell.pImage.image = UIImage(named: "xjh15")
        cell.pImage.image = imgA[indexPath.row]
        //if cell.pImage.image == nil{
        //    cell.pImage.image = downloadImage(NSURL(string: selected_playlist["tracks"][0]["track"]["albumArtRef"][0]["url"].stringValue)!)
        //}
        //if self.imgA.count == self.featuredPlaylists.count{
            //cell.pImage.image = self.imgA[indexPath.row]
        //}
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
        if "f2playlist" == segue.identifier{
            let dest = segue.destinationViewController as! PlaylistViewController
            let data = featuredPlaylists[tableView.indexPathForSelectedRow!.row]
            dest.playlist_data = data
            dest.pName = data["name"].stringValue
            dest.num = String(data["tracks"].count)
            dest.image = self.imgA[tableView.indexPathForSelectedRow!.row]
            dest.title = data["name"].stringValue
        }
    }

    
}
