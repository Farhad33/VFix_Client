//
//  LeftMenuViewController.swift
//  VFix_ios
//
//  Created by Youcef Iratni on 3/19/16.
//  Copyright © 2016 Majid Rahimi. All rights reserved.
//

import UIKit
import MMDrawerController

class LeftMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var MenuItems: [String] = ["Home","Profile","Appointments","Receipts","Support","Log Out"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return MenuItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("LeftMenuCell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = MenuItems[indexPath.row]
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        switch(indexPath.row)
        {
        case 0:
            var MainPageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
            var MainPageNav = UINavigationController(rootViewController: MainPageViewController)
            appDelegate.DrawerContainer!.centerViewController = MainPageNav
            appDelegate.DrawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            break
            
        case 1:
            var settingsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SettingsViewController") as! SettingsViewController
            var settingsPageNav = UINavigationController(rootViewController: settingsViewController)
            appDelegate.DrawerContainer!.centerViewController = settingsPageNav
            appDelegate.DrawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            break
            
        case 2:
            var appointmentsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("AppointmentsViewController") as! AppointmentsViewController
            var appointmentsPageNav = UINavigationController(rootViewController: appointmentsViewController)
            appDelegate.DrawerContainer!.centerViewController = appointmentsPageNav
            appDelegate.DrawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            break
        
        case 3:
            var receiptsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ReceiptsViewController") as! ReceiptsViewController
            var receiptsPageNav = UINavigationController(rootViewController: receiptsViewController)
            appDelegate.DrawerContainer!.centerViewController = receiptsPageNav
            appDelegate.DrawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            break
        
        case 4:
            var supportViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SupportViewController") as! SupportViewController
            var suppotrtPageNav = UINavigationController(rootViewController: supportViewController)
            appDelegate.DrawerContainer!.centerViewController = suppotrtPageNav
            appDelegate.DrawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
            break
            
        case 5:
            var MainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            var ContainerPage: ContainerViewController = MainStoryBoard.instantiateViewControllerWithIdentifier("ContainerViewController") as! ContainerViewController
            var ContainerPageNav = UINavigationController(rootViewController: ContainerPage)
            appDelegate.window?.rootViewController = ContainerPageNav
            break
            
        default:
            print("Option are not handlef")
        
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
