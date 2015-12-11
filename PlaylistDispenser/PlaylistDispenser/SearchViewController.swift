//
//  SearchViewController.swift
//  PlaylistDispenser
//
//  Created by Student 2 on 12/3/15.
//  Copyright © 2015 Student 2. All rights reserved.
//

import UIKit
import Parse

class SearchViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var searchBox: UITextField!
    var data:[PFObject]!
    var userData: PFObject?
    var ip: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBox.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func searchButtonClicked(sender: AnyObject) {
        search()
    }
    
    func search(){
        let searchText = searchBox.text
        let query = PFQuery(className: "playlists")
        if (searchText != nil) {
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
        search()
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
                    destinationVC.ip = self.ip
                    destinationVC.userData = self.userData
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
