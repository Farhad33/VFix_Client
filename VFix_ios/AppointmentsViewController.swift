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



private var Token = "22719873bdbb43cf0cc7f77d6e857e9e"
private var Key = "f8d0c6b95ab7f5316a7bff112b40bfd2def192a0"
private var BaseUrl = "http://www.agendize.com/api/2.0/scheduling/companies/13772899/appointments?clientId="
private var Id = "23830345"
var json: JSON!
var appointments: Array = [JSON]()

class AppointmentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var loadingView = DGElasticPullToRefreshLoadingViewCircle()
    var app = UIApplication.sharedApplication()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate.Design(navigationController!, View: view)
        
        tableView.delegate = self
        tableView.dataSource = self

        self.app.beginIgnoringInteractionEvents()
        NetworkRequest()
        appDelegate.Refresh(tableView)
        
    }
    
    
    
    func NetworkRequest()  {
        Alamofire.request(.GET, "\(BaseUrl)\(Id)&token=\(Token)&apiKey=\(Key)")
            .responseJSON { response in
                
                if response.result.isSuccess{
                    
                    if ARSLineProgress.shown { return }
                    
                        progressObject = NSProgress(totalUnitCount: 1)
                        ARSLineProgress.showWithProgressObject(progressObject!, completionBlock: {
                        print("Success completion block")
                       // ARSLineProgress.showSuccess()
                        self.view.userInteractionEnabled = true
                        self.app.endIgnoringInteractionEvents()
                        self.tableView.reloadData()
                    })
                    
                    self.progressDemoHelper(success: true)
                    print("success")
                    appointments.removeAll()
                    if let value = response.result.value {
                        let values = JSON(value)
                        for (_, i) in values["items"]{
                            appointments.append(i)
                        }
                        print(appointments)
                    }
                }else{
                    
                    print("dumb shit")
                }
                
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
            return appointments.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("AppointmentsCell", forIndexPath: indexPath) as! AppointmentsCell
        let appointment = appointments[indexPath.row]
        
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.dateFromString(appointment["start"]["dateTime"].stringValue)
        dateFormatter.timeStyle = .ShortStyle
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        let dateString = dateFormatter.stringFromDate(date!)
        cell.DateLabel.text = dateString
        cell.PriceLabel.text = appointment["price"].stringValue
        cell.AddressLabel.text = appointment["client"]["address"]["street"].stringValue
        cell.CityLabel.text = appointment["client"]["address"]["city"].stringValue
        return cell
    }
    
    @IBAction func LeftMenuButtonTapped(sender: AnyObject) {
        
        appDelegate.DrawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier) == "AppointsCellToDetails" {
            
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let appointment = appointments[indexPath!.row]
            let appointmentsDetailsVC = segue.destinationViewController as! AppointmentsDetailsVC
            
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let date = dateFormatter.dateFromString(appointment["start"]["dateTime"].stringValue)
            dateFormatter.timeStyle = .ShortStyle
            dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
            let dateString = dateFormatter.stringFromDate(date!)
            
            
            appointmentsDetailsVC.date = dateString
            appointmentsDetailsVC.price = appointment["price"].stringValue
            appointmentsDetailsVC.address = appointment["client"]["address"]["street"].stringValue
            appointmentsDetailsVC.city = appointment["client"]["address"]["city"].stringValue
            appointmentsDetailsVC.state = appointment["client"]["address"]["state"].stringValue
            appointmentsDetailsVC.zipCode = appointment["client"]["address"]["zipCode"].stringValue
            
            appointmentsDetailsVC.firstName = appointment["staff"]["firstName"].stringValue
            appointmentsDetailsVC.lastName = appointment["staff"]["lastName"].stringValue
            appointmentsDetailsVC.serviceType = appointment["service"]["name"].stringValue
        }
        
    }
}




private var progress: CGFloat = 0.0
private var progressObject: NSProgress?
private var isSuccess: Bool?

extension AppointmentsViewController {
    
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
