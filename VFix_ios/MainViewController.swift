//
//  MenuViewController.swift
//  VFix_ios
//
//  Created by Youcef Iratni on 3/15/16.
//  Copyright © 2016 Majid Rahimi. All rights reserved.
//

import UIKit
import MMDrawerController


class MainViewController: UIViewController {
    
    var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    override func viewDidLoad() {
        
        super.viewDidLoad()
       self.navigationController?.navigationBarHidden = false
     

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    // override func view

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func LeftMenuButtonTapped(sender: AnyObject) {
        
        appDelegate.DrawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
}
