//
//  KKKKKVC.swift
//  VFix_ios
//
//  Created by Youcef Iratni on 4/25/16.
//  Copyright © 2016 Majid Rahimi. All rights reserved.
//

    import UIKit
    import MMDrawerController
    import Alamofire
    import SwiftyJSON
    import AFNetworking
    import ARSLineProgress
    
    final class KKKKKVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
        private var Token = "22719873bdbb43cf0cc7f77d6e857e9e"
        private var loadingView = DGElasticPullToRefreshLoadingViewCircle()
        private var Key = "f8d0c6b95ab7f5316a7bff112b40bfd2def192a0"
        private var BaseUrl = "http://www.agendize.com/api/2.0/scheduling/companies/13772899/appointments?clientId="
        private var Id = "13804501"
        private var json: JSON!
        private var appointments: Array = [JSON]()
        private var progress: CGFloat = 0.0
        private var progressObject: NSProgress?
        private var Success: Bool?
        
        private var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        private var app = UIApplication.sharedApplication()
        
        @IBOutlet private weak var tableView: UITableView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.appDelegate.Design(navigationController!, View: view)
            
            self.tableView.delegate = self
            self.tableView.dataSource = self
            
            self.app.beginIgnoringInteractionEvents()
            
            let loadingView = DGElasticPullToRefreshLoadingViewCircle()
            loadingView.tintColor = UIColor(red: 249/255, green: 249/255, blue: 0/255, alpha: 1.0)
            self.tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
                self?.NetworkRequest { result in
                    guard let result = result else {
                        return
                    }
                    
                    var newAppointments = [JSON]()
                    for (_, i) in result["items"]{
                        newAppointments.append(i)
                    }
                    self?.appointments = newAppointments
                    self?.tableView.reloadData()
                }
                // tableView.reloadData()
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
                    self?.tableView.reloadData()
                    self?.tableView.dg_stopLoading()
                })
                }, loadingView: loadingView)
            
            ARSLineProgress.showWithPresentCompetionBlock { () -> Void in
                print("Showed with completion block")
            }
            
            self.NetworkRequest { result in
                guard let result = result else {
                    ARSLineProgress.showFail()
                    return
                }
                
                var newAppointments = [JSON]()
                for (_, i) in result["items"]{
                    newAppointments.append(i)
                }
                self.appointments = newAppointments
                ARSLineProgress.showSuccess()
                self.tableView.reloadData()
            }
            
            
            //        appDelegate.Refresh1(tableView)
            
        }
        
        func NetworkRequest(completion: ((result: JSON?) -> ())?)  {
            //        if ARSLineProgress.shown { return }
            //        ARSLineProgress.showWithPresentCompetionBlock { () -> Void in
            //            print("Showed with completion block")
            //        }
            Alamofire.request(.GET, "\(BaseUrl)\(Id)&token=\(Token)&apiKey=\(Key)")
                .responseJSON { response in
                    if response.result.isSuccess {
                        let value = response.result.value!
                        completion?(result: JSON(value))
                        self.view.userInteractionEnabled = true
                        self.app.endIgnoringInteractionEvents()
                    } else {
                        completion?(result: nil)
                    }
            }
        }
        
        
        
        //                    self.appointments.removeAll()
        //                    self.view.userInteractionEnabled = true
        //                    self.app.endIgnoringInteractionEvents()
        //                    self.tableView.reloadData()
        //                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(3 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
        //                        ARSLineProgress.hideWithCompletionBlock({ () -> Void in
        //                            print("Hidden with completion block")
        //                        })
        //                    })
        //                    ARSLineProgress.showSuccess()
        //                }else{
        //                    ARSLineProgress.showFail()
        //                    self.app.endIgnoringInteractionEvents()
        //                }
        
        //        }
        //    }
        
        func Refresh1(tableView: UITableView) {
            print("Refresh 1")
        }
        
        //        tableView.reloadData()
        
        //        // (red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        //        tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
        //            self!.NetworkRequest()
        //            // tableView.reloadData()
        //            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
        //
        //
        //                print("Refresh 2")
        //
        //
        //                tableView.reloadData()
        //                tableView.dg_stopLoading()
        //            })
        //            }, loadingView: loadingView)
        //        tableView.dg_setPullToRefreshFillColor(UIColor(red: 20/255.0, green: 157/255.0, blue: 234/255.0, alpha: 1.0))
        //        // (red: 57/255.0, green: 67/255.0, blue: 89/255.0, alpha: 1.0))
        //        tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
        //        tableView.reloadData()
        //        print("Refresh 3")
        
        
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
        
        deinit {
            self.tableView.dg_removePullToRefresh()
        }
}

//extension AppointmentsViewController {
//    
//    private func progressDemoHelper(success success: Bool) {
//        Success = success
//        launchTimer()
//    }
//    
//    private func launchTimer() {
//        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.7 * Double(NSEC_PER_SEC)));
//        
//        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
//            progressObject!.completedUnitCount += Int64(arc4random_uniform(30))
//            
//            if Success == false && progressObject?.fractionCompleted >= 0.7 {
//                ARSLineProgress.cancelPorgressWithFailAnimation(true, completionBlock: {
//                    print("Hidden with completion block")
//                })
//                return
//            } else {
//                if progressObject?.fractionCompleted >= 1.0 { return }
//            }
//            
//            self.launchTimer()
//        })
//    }
//    
//}






