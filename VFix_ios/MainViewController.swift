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


private var Token = "22719873bdbb43cf0cc7f77d6e857e9e"
private var Key = "f8d0c6b95ab7f5316a7bff112b40bfd2def192a0"
private var BaseUrl = "https://www.agendize.com/api/2.0/scheduling/"
private var Id = "companies/13772899/services"

private var services: Array = [JSON]()
private var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate


class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var app = UIApplication.sharedApplication()
    var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var defaults = NSUserDefaults.standardUserDefaults()
    var check4: Bool!
    var loadingView = DGElasticPullToRefreshLoadingViewCircle()
    
    override func viewDidLoad() {

        super.viewDidLoad()
        check4 = defaults.boolForKey("BoooLE")
        if check4 == false {
        self.app.beginIgnoringInteractionEvents()
        
        }
        services.removeAll()
        NetworkRequest()
        appDelegate.Refresh(tableView)
        appDelegate.Design(navigationController!, View: view)
    }
    
    
    func NetworkRequest() {
        Alamofire.request(.GET, "\(BaseUrl)\(Id)?apiKey=\(Key)&token=\(Token)")
            .responseJSON { response in
                
                if response.result.isSuccess{
                    
                    self.check4 = self.defaults.boolForKey("BoooLE")
                    if self.check4 == false {
                        if ARSLineProgress.shown { return }
                        
                        progressObject = NSProgress(totalUnitCount: 5)
                        ARSLineProgress.showWithProgressObject(progressObject!, completionBlock: {
                            print("Success completion block")
                            self.view.userInteractionEnabled = true
                            self.app.endIgnoringInteractionEvents()
                        })
                        
                        self.progressDemoHelper(success: true)
                        self.check4 = true
                        self.defaults.setBool(self.check4, forKey: "BoooLE")
                    }
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
                    self.tableView.reloadData()
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
    
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
//    override func viewWillAppear(animated: Bool) {

//    }
    
//    override func viewDidDisappear(animated: Bool) {
//         tableView.dg_removePullToRefresh()
//    }
    
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
        
        let service = services[indexPath.row]
        cell.MenuItemLabel.text = service["name"].stringValue
        let imageUrl = service["picture"]["url"].stringValue
        cell.IconImage.setImageWithURL(NSURL(string: imageUrl)!)
        return cell
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
