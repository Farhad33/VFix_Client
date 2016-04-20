//
//  ServiceInfosDetailVC.swift
//  VFix_ios
//
//  Created by Youcef Iratni on 4/7/16.
//  Copyright © 2016 Majid Rahimi. All rights reserved.
//

import UIKit

class ServiceInfosDetailVC: UIViewController {
    
    
    @IBOutlet weak var AddressTextField: UITextField!
    @IBOutlet weak var CityTextField: UITextField!
    @IBOutlet weak var StateTextField: UITextField!
    @IBOutlet weak var PostalCodeTextField: UITextField!
    
    var defaults = NSUserDefaults.standardUserDefaults()
    var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("View did Load")
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor =  UIColor(red: 20/255.0, green: 157/255.0, blue: 234/255.0, alpha: 1.0)
        self.view.backgroundColor = UIColor(hue: 212/360, saturation: 7/100, brightness: 100/100, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
      
        AddressTextField.text = defaults.stringForKey("addressLine1")
        CityTextField.text = defaults.stringForKey("city")
        StateTextField.text = defaults.stringForKey("state")
        PostalCodeTextField.text = defaults.stringForKey("postalCode")
        
    }

    override func viewWillAppear(animated: Bool) {
        print("View will Appear 1")
    
        let check = defaults.boolForKey("BoooL")
        
        if check == true {
            print("View will Appear 2")
        AddressTextField.text = defaults.stringForKey("addressLine11")
        CityTextField.text = defaults.stringForKey("city1")
        StateTextField.text = defaults.stringForKey("state1")
        PostalCodeTextField.text = defaults.stringForKey("postalCode1")
        }
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        print("View Will Disappear")
//        let check4 = defaults.boolForKey("BoooL")
//        var check2: Bool
//        if check4 == false{
//            check2 = false
//        } else {
//             check2 = true
//        }
        var check2 = true
    
        defaults.setBool(check2, forKey: "BoooL")
        
        let AddressLine11 = AddressTextField.text
        let City = CityTextField.text
        let State = StateTextField.text
        let PostalCode = PostalCodeTextField.text
        
        
        defaults.setObject(AddressLine11, forKey: "addressLine11")
        defaults.setObject(City, forKey: "city1")
        defaults.setObject(State, forKey: "state1")
        defaults.setObject(PostalCode, forKey: "postalCode1")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func OnSave(sender: AnyObject) {
        let AddressLine11 = AddressTextField.text
        let City = CityTextField.text
        let State = StateTextField.text
        let PostalCode = PostalCodeTextField.text
        
        
        defaults.setObject(AddressLine11, forKey: "addressLine11")
        defaults.setObject(City, forKey: "city1")
        defaults.setObject(State, forKey: "state1")
        defaults.setObject(PostalCode, forKey: "postalCode1")
        
        if AddressLine11 == nil || AddressLine11 == "" {
            var refreshAlert = UIAlertController(title: "Address Is Missing", message: "Please Inter an Address", preferredStyle: UIAlertControllerStyle.Alert)
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
            }))
            presentViewController(refreshAlert, animated: true, completion: nil)
        } else if City == nil || City == "" {
            var refreshAlert = UIAlertController(title: "City Is Missing", message: "Please Inter an City", preferredStyle: UIAlertControllerStyle.Alert)
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
            }))
            presentViewController(refreshAlert, animated: true, completion: nil)
        } else if State == nil || State == "" {
            var refreshAlert = UIAlertController(title: "State Is Missing", message: "Please Inter an State", preferredStyle: UIAlertControllerStyle.Alert)
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
            }))
            presentViewController(refreshAlert, animated: true, completion: nil)
        } else if PostalCode == nil || PostalCode == "" {
            var refreshAlert = UIAlertController(title: "Postal Code Is Missing", message: "Please Inter an Postal Code", preferredStyle: UIAlertControllerStyle.Alert)
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
            }))
            presentViewController(refreshAlert, animated: true, completion: nil)
        } else {
            
            let ServiceAddress = AddressTextField.text
            let ServiceCity = CityTextField.text
            let ServiceState = StateTextField.text
            let ServicePostalCode = PostalCodeTextField.text
            
            
            defaults.setObject(ServiceAddress, forKey: "serviceAddress")
            defaults.setObject(ServiceCity, forKey: "serviceCity")
            defaults.setObject(ServiceState, forKey: "serviceState")
            defaults.setObject(ServicePostalCode, forKey: "servicePostalCode")
            
            
            var refreshAlert = UIAlertController(title: "Reservation Compete", message: "Thanks For Using Vfix", preferredStyle: UIAlertControllerStyle.Alert)
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) in
            }))
            presentViewController(refreshAlert, animated: true, completion: nil)
            
            appDelegate.BuildUserInterface()
        }
        
        
        // || City == nil || City == "" || State == nil || State == "" || PostalCode == nil || PostalCode == "" || {
        
        
        
        
        
        
        
    }
    
    


}
