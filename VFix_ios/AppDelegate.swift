//
//  AppDelegate.swift
//  VFix_ios
//
//  Created by Majid Rahimi on 2/18/16.
//  Copyright © 2016 Majid Rahimi. All rights reserved.
//
let userDefaults = NSUserDefaults.standardUserDefaults()

import UIKit
import FBSDKCoreKit
import Fabric
import Crashlytics
import TwitterKit
import Parse
import MMDrawerController


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var DrawerContainer : MMDrawerController?
    var MainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var defaults = NSUserDefaults.standardUserDefaults()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        BuildUserInterface()
        
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
        
        
//        VfixClient.NetworkRequest("companies/13772899/services")
        
        userDefaults.synchronize()
        
        defaults.stringForKey("email")
        defaults.stringForKey("password")
        defaults.stringForKey("firstName")
        defaults.stringForKey("lastName")
        defaults.stringForKey("phoneNumber")
        defaults.stringForKey("addressLine1")
        defaults.stringForKey("addressLine2")
        defaults.stringForKey("city")
        defaults.stringForKey("state")
        defaults.stringForKey("postalCode")
        defaults.stringForKey("password")
        
        defaults.stringForKey("serviceAddress")
        defaults.stringForKey("serviceCity")
        defaults.stringForKey("serviceState")
        defaults.stringForKey("servicePostalCode")
        
        var check3 = false
        
        
        defaults.setBool(check3, forKey: "BoooL")
        
        //  defaults.boolForKey("BoooL")
        print("App Delegate")
        
        //**************
        
        var ContainerPage: ContainerViewController = MainStoryBoard.instantiateViewControllerWithIdentifier("ContainerViewController") as! ContainerViewController
        var ContainerPageNav = UINavigationController(rootViewController: ContainerPage)
        //                DrawerContainer!.centerViewController = ContainerPageNav
        //                DrawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        window?.rootViewController = ContainerPageNav as UINavigationController
        
        //**************
        
        //        userDefa ults.stringForKey("email")
        //        userDefaults.stringForKey("password")
        Fabric.with([Twitter.self])
        Fabric.with([Twitter.self, Crashlytics.self])
        // TODO: Move this to where you establish a user session
        self.logUser()
        
        
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        
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
        
        var MainPage: MainViewController = MainStoryBoard.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
        var LeftSideMenu: LeftMenuViewController = MainStoryBoard.instantiateViewControllerWithIdentifier("LeftMenuViewController") as! LeftMenuViewController
        var MainPageNav = UINavigationController(rootViewController: MainPage)
        var LeftSideMenuNav = UINavigationController(rootViewController: LeftSideMenu)
        
        DrawerContainer = MMDrawerController(centerViewController: MainPageNav, leftDrawerViewController: LeftSideMenuNav)
        DrawerContainer?.openDrawerGestureModeMask = MMOpenDrawerGestureMode.PanningCenterView
        DrawerContainer?.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.PanningCenterView
        
        //**************
        
        //        var ContainerPage: ContainerViewController = MainStoryBoard.instantiateViewControllerWithIdentifier("ContainerViewController") as! ContainerViewController
        //        var ContainerPageNav = UINavigationController(rootViewController: ContainerPage)
        //        DrawerContainer!.centerViewController = ContainerPageNav
        //        DrawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        
        //**************
        
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
    
    
    
}


