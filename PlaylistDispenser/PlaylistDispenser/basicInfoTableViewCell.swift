//
//  basicInfoTableViewCell.swift
//  PlaylistDispenser
//
//  Created by Student 2 on 11/17/15.
//  Copyright © 2015 Student 2. All rights reserved.
//

import UIKit

class basicInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var pUpload: UILabel!
    @IBOutlet weak var pTitle: UILabel!
    @IBOutlet weak var numSons: UILabel!
    @IBOutlet weak var pImage: UIImageView!
    @IBAction func saveBut(sender: AnyObject) {
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
