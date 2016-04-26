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
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var ProfilePicImage: UIImageView!
    @IBOutlet weak var EmailLabel: UILabel!
    
    
    
    
    var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var MenuItems: [String] = ["Home","Profile","Appointments","Receipts","Support","Log Out"]
    var MenuIcon: [String] = ["home.png", "Profile.png", "appointment.png", "Receipt.png", "Support.png", "exit.png"]
    var defaults = NSUserDefaults.standardUserDefaults()
    var check4: Bool!
    

    override func viewDidLoad() {
        super.viewDidLoad()
       // self.tableView.scrollEnabled = false
        self.navigationController?.navigationBarHidden = true
        self.view?.backgroundColor =  UIColor(red: 20/255.0, green: 157/255.0, blue: 234/255.0, alpha: 1.0)
        if defaults.stringForKey("firstName") == nil {
            NameLabel.text = "Youcef IRATNI"
        } else {
            NameLabel.text = defaults.stringForKey("firstName")! + " " + defaults.stringForKey("lastName")!
        }
            EmailLabel.text = defaults.stringForKey("email")
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
       //         defaults.removeObjectForKey("image")
            }
        }
        }
        ProfilePicImage.layer.borderWidth = 1
        ProfilePicImage.layer.masksToBounds = false
        ProfilePicImage.layer.borderColor = UIColor.blackColor().CGColor
        ProfilePicImage.layer.cornerRadius = ProfilePicImage.frame.height/2
        ProfilePicImage.clipsToBounds = true

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if defaults.stringForKey("firstName") == nil {
            NameLabel.text = "Youcef IRATNI"
        } else {
            NameLabel.text = defaults.stringForKey("firstName")! + " " + defaults.stringForKey("lastName")!
        }
        EmailLabel.text = defaults.stringForKey("email")
        
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
           //     defaults.removeObjectForKey("image")
                
            }
        }
        }
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
        let cell = tableView.dequeueReusableCellWithIdentifier("LeftMenuCell", forIndexPath: indexPath) as! LeftMenuCell
        
        cell.IconImage.image = UIImage(named: MenuIcon[indexPath.row])
        cell.MenuItemLabel.text = MenuItems[indexPath.row]
      //  cell.backgroundColor =  UIColor(red: 20/255.0, green: 157/255.0, blue: 234/255.0, alpha: 1.0)
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
            var refreshAlert = UIAlertController(title: "Log out", message: "Are You Sure?", preferredStyle: UIAlertControllerStyle.Alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action: UIAlertAction!) in
               // self.defaults.setObject(nil, forKey: "email")
                var MainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                var ContainerPage: ContainerViewController = MainStoryBoard.instantiateViewControllerWithIdentifier("ContainerViewController") as! ContainerViewController
                var ContainerPageNav = UINavigationController(rootViewController: ContainerPage)
                self.appDelegate.window?.rootViewController = ContainerPageNav
                self.check4 = false
                self.defaults.setBool(self.check4, forKey: "BoooLE")
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
                print("Canceled")
            }))
            presentViewController(refreshAlert, animated: true, completion: nil)
            
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
