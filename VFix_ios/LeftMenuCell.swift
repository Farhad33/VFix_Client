//
//  LeftMenuCell.swift
//  VFix_ios
//
//  Created by Youcef Iratni on 4/2/16.
//  Copyright © 2016 Majid Rahimi. All rights reserved.
//

import UIKit

class LeftMenuCell: UITableViewCell {
    
    @IBOutlet weak var IconImage: UIImageView!
    @IBOutlet weak var MenuItemLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
