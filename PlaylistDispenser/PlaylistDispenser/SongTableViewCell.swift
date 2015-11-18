//
//  SongTableViewCell.swift
//  PlaylistDispenser
//
//  Created by Student 2 on 11/18/15.
//  Copyright © 2015 Student 2. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {


    @IBOutlet weak var sTitle: UILabel!
    @IBOutlet weak var aTitle: UILabel!
    @IBOutlet weak var sLength: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
