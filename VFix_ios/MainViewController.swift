//
//  MenuViewController.swift
//  VFix_ios
//
//  Created by Youcef Iratni on 3/15/16.
//  Copyright © 2016 Majid Rahimi. All rights reserved.
//

import UIKit
import MMDrawerController
import Alamofire
import SwiftyJSON
import AFNetworking

var services: Array = [JSON]()

class MainViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var DiagnosticButton: UIButton!
//    @IBOutlet weak var virusRemovalButton: UIButton!
//    @IBOutlet weak var ElectronicSetupButton: UIButton!
//    @IBOutlet weak var PcTuneUpButton: UIButton!
//    @IBOutlet weak var PrinterSetupButton: UIButton!
//    @IBOutlet weak var DataBackUpButton: UIButton!
//    @IBOutlet weak var WifiSolutionButton: UIButton!
//    @IBOutlet weak var PcMacSupportButton: UIButton!
    
    
    
    
//    var MenuItems: [String] = ["VIRUS REMOVAL","DIAGNOSTIC AND REPAIR","ELECTRONIC SETUP","PC TUNE-UP","PRINTER SETUP","DATA BACKUP", "WIFI SOLUTIONS", "PC/MAC SUPPORT"]
//    var MenuIcon: [String] = ["home.png", "Profile.png", "appointment.png", "Receipt.png", "Support.png", "exit.png", "exit.png", "exit.png"]
    
    var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//    static var service = ""

    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor =  UIColor(red: 20/255.0, green: 157/255.0, blue: 234/255.0, alpha: 1.0)
        self.view.backgroundColor = UIColor(hue: 212/360, saturation: 7/100, brightness: 100/100, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        services.removeAll()
        
        for (_,i) in VfixClient.json["items"] {
            services.append(i)
        }
        
//        for i in services {
//            print(i["id"])
//            print(i["name"])
//            print(i["picture"]["url"])
//        }
        print(services.count)

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
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return services.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("MainVCCell", forIndexPath: indexPath) as! MainVCCell
        
        
      //  image = UIImage(named: services[indexPath.row])
        let service = services[indexPath.row]
        cell.MenuItemLabel.text = service["name"].stringValue
        let imageUrl = service["picture"]["url"].stringValue
        
        cell.IconImage.setImageWithURL(NSURL(string: imageUrl)!)
//        cell.IconImage.setImageWithURL(NSURL(string: imageUrl)!)
        
        
       // .image = imageUrl
        //  cell.backgroundColor =  UIColor(red: 20/255.0, green: 157/255.0, blue: 234/255.0, alpha: 1.0)
        return cell
    }

    
    

    
//    @IBAction func onServices(sender: AnyObject) {
//        
//        if sender as! NSObject == virusRemovalButton{
//            MainViewController.service = "13772900"
//        }else if sender as! NSObject == DiagnosticButton{
//            MainViewController.service = "22222222"
//        }else if sender as! NSObject == ElectronicSetupButton{
//            MainViewController.service = "33333333"
//        }else if sender as! NSObject == PcTuneUpButton{
//            MainViewController.service = "44444444"
//        }else if sender as! NSObject == PrinterSetupButton{
//            MainViewController.service = "55555555"
//        }else if sender as! NSObject == DataBackUpButton{
//            MainViewController.service = "66666666"
//        }else if sender as! NSObject == WifiSolutionButton{
//            MainViewController.service = "77777777"
//        }else if sender as! NSObject == PcMacSupportButton{
//            MainViewController.service = "88888888"
//        }
//        self.performSegueWithIdentifier("goToCalanderSegue", sender: self)
//        
//    }
    
    
    
}
