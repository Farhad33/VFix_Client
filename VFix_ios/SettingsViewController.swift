//
//  SettingsViewController.swift
//  VFix_ios
//
//  Created by Youcef Iratni on 3/22/16.
//  Copyright © 2016 Majid Rahimi. All rights reserved.
//

import UIKit
import MMDrawerController
import Alamofire
import SwiftyJSON


class SettingsViewController: UIViewController {
    
    var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var defaults = NSUserDefaults.standardUserDefaults()
    
    
    @IBOutlet weak var ProfilePicImage: UIImageView!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var PhoneNumLabel: UILabel!
    @IBOutlet weak var AddressLineOneLabel: UILabel!
    @IBOutlet weak var AddressLineTwoLabel: UILabel!
    @IBOutlet weak var CityLabel: UILabel!
    @IBOutlet weak var StateLabel: UILabel!
    @IBOutlet weak var PostalCodeLabel: UILabel!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor =  UIColor(red: 20/255.0, green: 157/255.0, blue: 234/255.0, alpha: 1.0)
        self.view.backgroundColor = UIColor(hue: 212/360, saturation: 7/100, brightness: 100/100, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        UserVC.sharedManager.NetworkRequest()
        
        
        
        if defaults.stringForKey("firstName") == nil {
            NameLabel.text = ""
        } else {
            NameLabel.text = "    " + defaults.stringForKey("firstName")! + " " + defaults.stringForKey("lastName")!
        }
        
        // NameLabel.text = "    " + defaults.stringForKey("firstName")! + " " + defaults.stringForKey("lastName")!
        
        if defaults.stringForKey("email") == nil {
            EmailLabel.text = ""
        } else {
            EmailLabel.text = "    " + defaults.stringForKey("email")!
        }
        
     //   EmailLabel.text = "    " + defaults.stringForKey("email")!
        if defaults.stringForKey("phoneNumber") == nil {
            PhoneNumLabel.text = " "
        } else {
            PhoneNumLabel.text = "    " + defaults.stringForKey("phoneNumber")!
        }
        
        if defaults.stringForKey("addressLine1") == nil {
            AddressLineOneLabel.text = " "
        } else {
            AddressLineOneLabel.text = "    " + defaults.stringForKey("addressLine1")!
        }
        
        if defaults.stringForKey("addressLine2") == nil {
            AddressLineTwoLabel.text = " "
        } else {
            AddressLineTwoLabel.text = "    " + defaults.stringForKey("addressLine2")!
        }
        
        if defaults.stringForKey("city") == nil {
            CityLabel.text = " "
        } else {
            CityLabel.text = "    " + defaults.stringForKey("city")!
        }
        
        if defaults.stringForKey("state") == nil {
            StateLabel.text = " "
        } else {
            StateLabel.text = "    " + defaults.stringForKey("state")!
        }
        
        if defaults.stringForKey("postalCode") == nil {
            PostalCodeLabel.text = " "
        } else {
            PostalCodeLabel.text = "    " + defaults.stringForKey("postalCode")!
        }
        
        
        
        if ProfilePicImage.image == nil {
            ProfilePicImage.image = UIImage(named: "missing.png")
        } else {
        if let imgData = defaults.objectForKey("image") as? NSData
        {
            if let image = UIImage(data: imgData)
            {
                //set image in UIImageView imgSignature
                self.ProfilePicImage.image = image
                //remove cache after fetching image data
          //      defaults.removeObjectForKey("image")
            }
        }
        }
        ProfilePicImage.layer.borderWidth = 1
        ProfilePicImage.layer.masksToBounds = false
        ProfilePicImage.layer.borderColor = UIColor.blackColor().CGColor
        ProfilePicImage.layer.cornerRadius = ProfilePicImage.frame.height/2
        ProfilePicImage.clipsToBounds = true
        
   //     ProfilePicImage.image = defaults.u
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if defaults.stringForKey("firstName") == nil {
            NameLabel.text = ""
        } else {
            NameLabel.text = "    " + defaults.stringForKey("firstName")! + " " + defaults.stringForKey("lastName")!
        }
        
        // NameLabel.text = "    " + defaults.stringForKey("firstName")! + " " + defaults.stringForKey("lastName")!
        if defaults.stringForKey("email") == nil {
            EmailLabel.text = ""
        } else {
            EmailLabel.text = "    " + defaults.stringForKey("email")!
        }
        if defaults.stringForKey("phoneNumber") == nil {
            PhoneNumLabel.text = " "
        } else {
            PhoneNumLabel.text = "    " + defaults.stringForKey("phoneNumber")!
        }
        
        if defaults.stringForKey("addressLine1") == nil {
            AddressLineOneLabel.text = " "
        } else {
            AddressLineOneLabel.text = "    " + defaults.stringForKey("addressLine1")!
        }
        
        if defaults.stringForKey("addressLine2") == nil {
            AddressLineTwoLabel.text = " "
        } else {
            AddressLineTwoLabel.text = "    " + defaults.stringForKey("addressLine2")!
        }
        
        if defaults.stringForKey("city") == nil {
            CityLabel.text = " "
        } else {
            CityLabel.text = "    " + defaults.stringForKey("city")!
        }
        
        if defaults.stringForKey("state") == nil {
            StateLabel.text = " "
        } else {
            StateLabel.text = "    " + defaults.stringForKey("state")!
        }
        
        if defaults.stringForKey("postalCode") == nil {
            PostalCodeLabel.text = " "
        } else {
            PostalCodeLabel.text = "    " + defaults.stringForKey("postalCode")!
        }
        if ProfilePicImage.image == nil {
            ProfilePicImage.image = UIImage(named: "missing.png")
        } else {
        if let imgData = defaults.objectForKey("image") as? NSData
        {
            if let image = UIImage(data: imgData)
            {
                //set image in UIImageView imgSignature
                self.ProfilePicImage.image = image
                //remove cache after fetching image data
             //   defaults.removeObjectForKey("image")
            }
        }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LeftMenuButtonTapped(sender: AnyObject) {
        
        appDelegate.DrawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
}
