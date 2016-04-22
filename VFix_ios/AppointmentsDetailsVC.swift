//
//  AppointmentsDetailsVC.swift
//  VFix_ios
//
//  Created by Youcef Iratni on 4/21/16.
//  Copyright © 2016 Majid Rahimi. All rights reserved.
//

import UIKit
import MMDrawerController
import Alamofire
import SwiftyJSON
import AFNetworking
import ARSLineProgress


class AppointmentsDetailsVC: UIViewController {
    
    @IBOutlet weak var TechPicture: UIImageView!
    @IBOutlet weak var TechFirstNameLabel: UILabel!
    @IBOutlet weak var TechLastNameLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var AddressLabel: UILabel!
    @IBOutlet weak var ServiceTypeLabel: UILabel!
    @IBOutlet weak var PriceLabel: UILabel!
    
    var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var date = ""
    var address = ""
    var price = ""
    var firstName = ""
    var lastName = ""
    var serviceType = ""
    var city = ""
    var state = ""
    var zipCode = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.Design(navigationController!, View: view)
        ReshapePicture()
        
        DateLabel.text = date
        PriceLabel.text = price
        AddressLabel.text = address + ", " + city + ", " + state + ", " + zipCode
        TechFirstNameLabel.text = firstName
        TechLastNameLabel.text = lastName
        ServiceTypeLabel.text = serviceType
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func ReshapePicture(){
        TechPicture.layer.borderWidth = 1
        TechPicture.layer.masksToBounds = false
        TechPicture.layer.borderColor = UIColor.blackColor().CGColor
        TechPicture.layer.cornerRadius = TechPicture.frame.height/2
        TechPicture.clipsToBounds = true
    }
    
    
}
