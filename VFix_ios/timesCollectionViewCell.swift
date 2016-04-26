//
//  timesCollectionViewCell.swift
//  VFix_ios
//
//  Created by Youcef Iratni on 4/19/16.
//  Copyright © 2016 Majid Rahimi. All rights reserved.
//

import UIKit

class timesCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var availableTimesLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedBackgroundView = UIView(frame: contentView.bounds)
        selectedBackgroundView!.backgroundColor = UIColor(red: 31/256, green: 119/256, blue: 219/256, alpha: 1)
    }
}
