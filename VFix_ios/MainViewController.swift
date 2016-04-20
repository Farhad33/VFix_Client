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
import ARSLineProgress

private var Token: String = "22719873bdbb43cf0cc7f77d6e857e9e"
private var Key: String = "f8d0c6b95ab7f5316a7bff112b40bfd2def192a0"
private var Url: String = "https://www.agendize.com/api/2.0/scheduling/"
private var endPoint: String = "companies/13772899/services"

var services: Array = [JSON]()
var rawServises: JSON!
var tableChecker = false


class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var app = UIApplication.sharedApplication()
    var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var defaults = NSUserDefaults.standardUserDefaults()
    var check4: Bool!
    var loadingView = DGElasticPullToRefreshLoadingViewCircle()
    
    private func NetworkRequest(endPoint: String)  {
        Alamofire.request(.GET, "\(Url)\(endPoint)?apiKey=\(Key)&token=\(Token)")
            .responseJSON { response in
                
                if response.result.isSuccess{
                    
                    
                    self.check4 = self.defaults.boolForKey("BoooLE")
                    if self.check4 == false {
                            if ARSLineProgress.shown { return }
                    
                            progressObject = NSProgress(totalUnitCount: 100)
                            ARSLineProgress.showWithProgressObject(progressObject!, completionBlock: {
                            print("Success completion block")
                            self.view.userInteractionEnabled = true
                            self.app.endIgnoringInteractionEvents()
                            })
                    
                            self.progressDemoHelper(success: true)
                            self.check4 = true
                            self.defaults.setBool(self.check4, forKey: "BoooLE")
                    }
                        
                    
                    
                    
                    if let value = response.result.value {
                        rawServises = JSON(value)
                        
                        services.removeAll()
                        
                        for (_,i) in rawServises["items"] {
                            services.append(i)
                        }
                        
                        tableChecker = true
                        self.tableView.delegate = self
                        self.tableView.dataSource = self
                        self.tableView.reloadData()
                        
                        
                    }
                  
                }else{
                    if ARSLineProgress.shown { return }
                    
                    progressObject = NSProgress(totalUnitCount: 100)
                    
                    ARSLineProgress.showWithProgressObject(progressObject!, completionBlock: {
                        print("This copmletion block is going to be overriden by cancel completion block in launchTimer() method.")
                    })
                    
                    self.progressDemoHelper(success: false)
                    self.app.endIgnoringInteractionEvents()
                    self.check4 = true
                    self.defaults.setBool(self.check4, forKey: "BoooLE")
                }
        }
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        check4 = defaults.boolForKey("BoooLE")
        if check4 == false {
        self.app.beginIgnoringInteractionEvents()
        
        }
        NetworkRequest(endPoint)
        
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor =  UIColor(red: 20/255.0, green: 157/255.0, blue: 234/255.0, alpha: 1.0)
        self.view.backgroundColor = UIColor(hue: 212/360, saturation: 7/100, brightness: 100/100, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        Refresh()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
//    override func viewWillAppear(animated: Bool) {
//        Refresh()
//    }
    
    override func viewDidDisappear(animated: Bool) {
         tableView.dg_removePullToRefresh()
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
        if tableChecker == false{
            return 0
        }else{
            return services.count
        }
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
    
    
    func Refresh() {
//        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor(red: 249/255, green: 249/255, blue: 0/255, alpha: 1.0)
        tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
                self?.tableView.dg_stopLoading()
//                self?.tableView.reloadData()
            })
            }, loadingView: loadingView)
        tableView.dg_setPullToRefreshFillColor(UIColor(red: 20/255.0, green: 157/255.0, blue: 234/255.0, alpha: 1.0))
        tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
       
    }
}


private var progress: CGFloat = 0.0
private var progressObject: NSProgress?
private var isSuccess: Bool?

extension MainViewController {
    
    private func progressDemoHelper(success success: Bool) {
        isSuccess = success
        launchTimer()
    }
    
    private func launchTimer() {
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.7 * Double(NSEC_PER_SEC)));
        
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            progressObject!.completedUnitCount += Int64(arc4random_uniform(30))
            
            if isSuccess == false && progressObject?.fractionCompleted >= 0.7 {
                ARSLineProgress.cancelPorgressWithFailAnimation(true, completionBlock: {
                    print("Hidden with completion block")
                })
                return
            } else {
                if progressObject?.fractionCompleted >= 1.0 { return }
            }
            
            self.launchTimer()
        })
    }
    
}
