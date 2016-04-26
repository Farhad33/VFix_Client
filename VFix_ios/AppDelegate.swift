//
//  AppDelegate.swift
//  VFix_ios
//
//  Created by Majid Rahimi on 2/18/16.
//  Copyright © 2016 Majid Rahimi. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import Fabric
import Crashlytics
import TwitterKit
import MMDrawerController
import Parse
import Alamofire
import SwiftyJSON
import AFNetworking
import ARSLineProgress

var makeAppointment = Appointment()
var makeClient = Client()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var DrawerContainer : MMDrawerController?
    var MainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    
     var Token = "22719873bdbb43cf0cc7f77d6e857e9e"
     var Key = "f8d0c6b95ab7f5316a7bff112b40bfd2def192a0"
     var BaseUrl = "http://www.agendize.com/api/2.0/scheduling/companies/13772899/appointments?clientId="
     var Id = "13804501"
     var json: JSON!
     var appointments: Array = [JSON]()


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        Parse.initializeWithConfiguration(
            ParseClientConfiguration(block: { (configuration:ParseMutableClientConfiguration) -> Void in
                configuration.applicationId = "VFix"
                configuration.clientKey = "ftyerswftuyiluiuyertdfgsoiyftyft56resr"
                configuration.server = "https://blooming-sands-26555.herokuapp.com/parse"
            })
        )
        
        if PFUser.currentUser() != nil {
            let loggedinVC = MainStoryBoard.instantiateViewControllerWithIdentifier("MainViewController")
            window?.rootViewController = loggedinVC
        }
        
        BuildUserInterface()
        
        let ContainerPage: ContainerViewController = MainStoryBoard.instantiateViewControllerWithIdentifier("ContainerViewController") as! ContainerViewController
        let ContainerPageNav = UINavigationController(rootViewController: ContainerPage)
        
        window?.rootViewController = ContainerPageNav as UINavigationController
        
        Fabric.with([Twitter.self])
        Fabric.with([Twitter.self, Crashlytics.self])
        // TODO: Move this to where you establish a user session
        self.logUser()
        
        
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func BuildUserInterface(){
        
        let MainPage: MainViewController = MainStoryBoard.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
        let LeftSideMenu: LeftMenuViewController = MainStoryBoard.instantiateViewControllerWithIdentifier("LeftMenuViewController") as! LeftMenuViewController
        let MainPageNav = UINavigationController(rootViewController: MainPage)
        let LeftSideMenuNav = UINavigationController(rootViewController: LeftSideMenu)
        
        DrawerContainer = MMDrawerController(centerViewController: MainPageNav, leftDrawerViewController: LeftSideMenuNav)
        DrawerContainer?.openDrawerGestureModeMask = MMOpenDrawerGestureMode.PanningCenterView
        DrawerContainer?.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.PanningCenterView
        
        window?.rootViewController = DrawerContainer
        // ! as UIViewController
        
    }
    
    
    func logUser() {
        // TODO: Use the current user's information
        // You can call any combination of these three methods
        Crashlytics.sharedInstance().setUserEmail("user@fabric.io")
        Crashlytics.sharedInstance().setUserIdentifier("12345")
        Crashlytics.sharedInstance().setUserName("Test User")
        let GGGG = Crashlytics.sharedInstance().setUserEmail("user@fabric.io")
        print("Your Email Is: \(GGGG)")
    }
    
    
    func Refresh(tableView: UITableView) {
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor(red: 249/255, green: 249/255, blue: 0/255, alpha: 1.0)
        // (red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(1.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
                tableView.reloadData()
                tableView.dg_stopLoading()
                
            })
            }, loadingView: loadingView)
        tableView.dg_setPullToRefreshFillColor(UIColor(red: 20/255.0, green: 157/255.0, blue: 234/255.0, alpha: 1.0))
        // (red: 57/255.0, green: 67/255.0, blue: 89/255.0, alpha: 1.0))
        tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
        
    }
    
//    func Refresh1(tableView: UITableView) {
//        print("Refresh 1")
//        
//        tableView.reloadData()
//        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
//        loadingView.tintColor = UIColor(red: 249/255, green: 249/255, blue: 0/255, alpha: 1.0)
//        // (red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
//        tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
//            self!.NetworkRequest1()
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
//        
//    }
    
    
//    func NetworkRequest1()  {
//        Alamofire.request(.GET, "\(BaseUrl)\(Id)&token=\(Token)&apiKey=\(Key)")
//            .responseJSON { response in
//                if response.result.isSuccess{
//                    self.appointments.removeAll()
//                    if let value = response.result.value {
//                        let values = JSON(value)
//                        for (_, i) in values["items"]{
//                            self.appointments.append(i)
//                        }
//                   //     print(self.appointments)
//                   //     tableView.reloadData()
//                    }
//                }else{
//                }
//                
//        }
//    }
    
    
    func Design(NavController: UINavigationController, View: UIView){
        NavController.setNavigationBarHidden(false, animated:true)
        NavController.navigationBar.barTintColor =  UIColor(red: 20/255.0, green: 157/255.0, blue: 234/255.0, alpha: 1.0)
        View.backgroundColor = UIColor(hue: 212/360, saturation: 7/100, brightness: 100/100, alpha: 1.0)
        NavController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        NavController.navigationBar.tintColor = UIColor.whiteColor()
    }
    

}

