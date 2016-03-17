//
//  ContainerViewController.swift
//  VFix_ios
//
//  Created by Majid Rahimi on 2/25/16.
//  Copyright © 2016 Majid Rahimi. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var signUpButtom: UIButton!
    @IBOutlet weak var loginButtom: UIButton!
    
    var containerPageViewController: VFixPageViewController? {
        didSet {
            containerPageViewController?.vfixDelegate = self
        }
    }
    
    override func viewDidLoad() {
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let containerPageViewController = segue.destinationViewController as? VFixPageViewController {
            self.containerPageViewController = containerPageViewController
        }
    }
    

    @IBAction func signupOrLogin(sender: AnyObject) {
        if sender as! NSObject == signUpButtom{
//            SignUpViewController
        }
        
        if sender as! NSObject == loginButtom{
            
        }
    }
    
}

extension ContainerViewController: VFixPageViewControllerDelegate {
    
    func vfixPageViewController(vfixPageViewController: VFixPageViewController,
        didUpdatePageCount count: Int){
        pageControl.numberOfPages = count
    }
    
    func vfixPageViewController(vfixPageViewController: VFixPageViewController,
        didUpdatePageIndex index: Int){
        pageControl.currentPage = index
    }


}
