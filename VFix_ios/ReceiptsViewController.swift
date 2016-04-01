//
//  ReceiptsViewController.swift
//  VFix_ios
//
//  Created by Youcef Iratni on 3/22/16.
//  Copyright © 2016 Majid Rahimi. All rights reserved.
//

import UIKit
import MMDrawerController

class ReceiptsViewController: UIViewController {
    
    var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor =  UIColor(red: 20/255.0, green: 157/255.0, blue: 234/255.0, alpha: 1.0)
        self.view.backgroundColor = UIColor(hue: 212/360, saturation: 7/100, brightness: 100/100, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func LeftMenuButtonTapped(sender: AnyObject) {
        
        appDelegate.DrawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }

}
