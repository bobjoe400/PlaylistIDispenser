//
//  SearchViewController.swift
//  PlaylistDispenser
//
//  Created by Student 2 on 12/3/15.
//  Copyright © 2015 Student 2. All rights reserved.
//

import UIKit
import Parse

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBox: UITextField!
    var data:[PFObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func searchButtonClicked(sender: AnyObject) {
        var searchText = searchBox.text
        let query = PFQuery(className: "playlists")
        if (searchText != nil) {
            //let predicate = NSPredicate(format: "name ="+searchText!)
            //query = PFQuery(className: "playlists", predicate: predicate)
            query.whereKey("name", matchesRegex: searchText!, modifiers: "i")
        }
        query.findObjectsInBackgroundWithBlock {
            (results, error) -> Void in
            self.data = results as [PFObject]?
            print(self.data)
            if (self.data != nil) {
                self.performSegueWithIdentifier("ShowDetailsSegue", sender: self)
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetailsSegue" {
            if let destinationVC = segue.destinationViewController as? SearchResultTableViewController{
                if (data != nil) {
                    destinationVC.dataToDisplay = data
                }
                
            }
        }
        if segue.identifier == "toExport" {
            let dest = segue.destinationViewController as! ExportViewController
            dest.whereFrom = "search"
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
