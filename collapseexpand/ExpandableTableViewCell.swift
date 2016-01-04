//
//  ExpandableTableViewCell.swift
//  collapseexpand
//
//  Created by Vishal Gandhi on 11/28/15.
//  Copyright © 2015 Vishal Gandhi. All rights reserved.
//

import UIKit

class ExpandableTableViewCell: UITableViewCell {
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var btnExpand: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
