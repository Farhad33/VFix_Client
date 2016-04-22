//
//  AppointmentsCell.swift
//  VFix_ios
//
//  Created by Youcef Iratni on 4/19/16.
//  Copyright © 2016 Majid Rahimi. All rights reserved.
//

import UIKit
import MMDrawerController
import Alamofire
import SwiftyJSON
import AFNetworking
import ARSLineProgress

class AppointmentsCell: UITableViewCell {
    
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var PriceLabel: UILabel!
    @IBOutlet weak var AddressLabel: UILabel!
    @IBOutlet weak var CityLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor(hue: 212/360, saturation: 7/100, brightness: 100/100, alpha: 1.0)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
