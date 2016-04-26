//
//  MainVCCell.swift
//  VFix_ios
//
//  Created by Youcef Iratni on 4/14/16.
//  Copyright © 2016 Majid Rahimi. All rights reserved.
//

import UIKit
import AFNetworking

class MainVCCell: UITableViewCell {
    
    @IBOutlet weak var IconImage: UIImageView!
    @IBOutlet weak var MenuItemLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(hue: 212/360, saturation: 7/100, brightness: 100/100, alpha: 1.0)
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
