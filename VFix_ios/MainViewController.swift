//
//  MenuViewController.swift
//  VFix_ios
//
//  Created by Youcef Iratni on 3/15/16.
//  Copyright © 2016 Majid Rahimi. All rights reserved.
//

private var Token = "22719873bdbb43cf0cc7f77d6e857e9e"
private var Key = "f8d0c6b95ab7f5316a7bff112b40bfd2def192a0"
private var BaseUrl = "https://www.agendize.com/api/2.0/scheduling/"
private var Id = "companies/13772899/services"

import UIKit
import MMDrawerController
import Alamofire
import SwiftyJSON
import AFNetworking

private var services: Array = [JSON]()
private var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        print("viewDidLoad")
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor =  UIColor(red: 20/255.0, green: 157/255.0, blue: 234/255.0, alpha: 1.0)
        self.view.backgroundColor = UIColor(hue: 212/360, saturation: 7/100, brightness: 100/100, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        services.removeAll()
        NetworkRequest()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
        print("viewDidAppear")
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
        print("Majid2")

    }
    
    
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func NetworkRequest()  {
        Alamofire.request(.GET, "\(BaseUrl)\(Id)?apiKey=\(Key)&token=\(Token)")
            .responseJSON { response in
                
                if response.result.isSuccess{
                    print("success")
                    if let value = response.result.value {
                        let values = JSON(value)
                        for (_,i) in values["items"] {
                            services.append(i)
                        }
                    }
                    self.tableView.reloadData()
                    self.tableView.dataSource = self
                    self.tableView.delegate = self
                    print("done")
                }else{
                    print("dumb shit")
                }
        }
    }
    
    @IBAction func LeftMenuButtonTapped(sender: AnyObject) {
        
        appDelegate.DrawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print(services.count)
        return services.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("MainVCCell", forIndexPath: indexPath) as! MainVCCell
        
        let service = services[indexPath.row]
        cell.MenuItemLabel.text = service["name"].stringValue
        let imageUrl = service["picture"]["url"].stringValue
        
        cell.IconImage.setImageWithURL(NSURL(string: imageUrl)!)

        return cell
    }
    

    
}
