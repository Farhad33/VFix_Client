//
//  ServiceInfosDetailVC.swift
//  VFix_ios
//
//  Created by Youcef Iratni on 4/7/16.
//  Copyright © 2016 Majid Rahimi. All rights reserved.
//

import UIKit
import MMDrawerController

class ServiceInfosDetailVC: UIViewController {
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var AddressTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var CityTextField: UITextField!
    @IBOutlet weak var StateTextField: UITextField!
    @IBOutlet weak var PostalCodeTextField: UITextField!
    
    var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getClient()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        print("View will Appear 1")
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        print("View Will Disappear")
        setClient()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    
    func getClient() {
        firstNameTextField.text! = makeClient.firstName
        lastNameTextField.text! = makeClient.lastName
        emailAddressTextField.text! = makeClient.email
        phoneNumberTextField.text! = makeClient.phone
        AddressTextField.text! = makeClient.street
        CityTextField.text! = makeClient.city
        StateTextField.text! = makeClient.state
        PostalCodeTextField.text! = makeClient.zipCode
    }
    
    
    func setClient() {
        makeClient.firstName = firstNameTextField.text!
        makeClient.lastName = lastNameTextField.text!
        makeClient.email = emailAddressTextField.text!
        makeClient.phone = phoneNumberTextField.text!
        makeClient.street = AddressTextField.text!
        makeClient.city = CityTextField.text!
        makeClient.state = StateTextField.text!
        makeClient.zipCode = PostalCodeTextField.text!
    }
    
    
    @IBAction func OnSave(sender: AnyObject) {
        
        setClient()
        
        if makeClient.ValidAll {

            let refreshAlert = UIAlertController(title: "Reservation Complete", message: "Thank you for using VFix", preferredStyle: UIAlertControllerStyle.Alert)
            refreshAlert.addAction(UIAlertAction(title: "OK", style: .Default,
                handler: { (action: UIAlertAction!) in
                let appointmentsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("AppointmentsViewController") as! AppointmentsViewController
                let appointmentsPageNav = UINavigationController(rootViewController: appointmentsViewController)
                self.appDelegate.DrawerContainer!.centerViewController = appointmentsPageNav
            }))
            presentViewController(refreshAlert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Error", message: "One or all of the fields are missing", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
    }
    
}

