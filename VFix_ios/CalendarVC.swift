//
//  CalendarVC.swift
//  VFix_ios
//
//  Created by Youcef Iratni on 4/2/16.
//  Copyright © 2016 Majid Rahimi. All rights reserved.
//

import UIKit

class CalendarVC: UIViewController {
 

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.setNavigationBarHidden(false, animated:true)
        self.navigationController?.navigationBar.barTintColor =  UIColor(red: 20/255.0, green: 157/255.0, blue: 234/255.0, alpha: 1.0)
        self.view.backgroundColor = UIColor(hue: 212/360, saturation: 7/100, brightness: 100/100, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        
        print("Calendar viewDidLoad")
//        print(MainViewController.service)
        

      
    }
    
    override func viewWillAppear(animated: Bool) {
        print("Calendar View will Appear")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
