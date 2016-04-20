//
//  AppointmentsViewController.swift
//  VFix_ios
//
//  Created by Youcef Iratni on 3/22/16.
//  Copyright © 2016 Majid Rahimi. All rights reserved.
//

import UIKit
import MMDrawerController
import Alamofire
import SwiftyJSON
import AFNetworking
import ARSLineProgress


private var Token: String = "22719873bdbb43cf0cc7f77d6e857e9e"
private var Key: String = "f8d0c6b95ab7f5316a7bff112b40bfd2def192a0"
private var Url: String = "https://www.agendize.com/api/2.0/scheduling/"
private var endPoint: String = "companies/13772899/appointments?client.id=1380450"
var json: JSON!

class AppointmentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var loadingView = DGElasticPullToRefreshLoadingViewCircle()
    
    func NetworkRequest()  {
        Alamofire.request(.GET, "\(Url)\(endPoint)?apiKey=\(Key)&token=\(Token)")
            .responseJSON { response in
                
                if response.result.isSuccess{
                    if let value = response.result.value {
                        json = JSON(value)
                        print(json)
                    }
                }else{
                    print("dumb shit")
                }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkRequest()
        self.navigationController?.navigationBar.barTintColor =  UIColor(red: 20/255.0, green: 157/255.0, blue: 234/255.0, alpha: 1.0)
        self.view.backgroundColor = UIColor(hue: 212/360, saturation: 7/100, brightness: 100/100, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
        
        Refresh()
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        tableView.dg_removePullToRefresh()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
            return 3
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("AppointmentsCell", forIndexPath: indexPath) as! AppointmentsCell
   //     cell.DateTextField.text = service["name"].stringValue
        return cell
    }
    
    
    func Refresh() {
        //        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
                self?.tableView.dg_stopLoading()
                //                self?.tableView.reloadData()
            })
            }, loadingView: loadingView)
        tableView.dg_setPullToRefreshFillColor(UIColor(red: 57/255.0, green: 67/255.0, blue: 89/255.0, alpha: 1.0))
        tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
        
    }
    
    @IBAction func LeftMenuButtonTapped(sender: AnyObject) {
        
        appDelegate.DrawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
}
