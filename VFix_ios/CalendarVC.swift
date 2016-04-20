//
//  CalendarVC.swift
//  VFix_ios
//
//  Created by Youcef Iratni on 4/2/16.
//  Copyright © 2016 Majid Rahimi. All rights reserved.
//

import SwiftMoment
import UIKit
import SwiftyJSON
import Alamofire
import FSCalendar


var sessionToken = "22719873bdbb43cf0cc7f77d6e857e9e"
var baseUrl = "companies/13772899/widget/freeSlots?serviceId=13772901&startDate=2016-04-18&endDate=2016-04-19"
let APIKey = "f8d0c6b95ab7f5316a7bff112b40bfd2def192a0"
let Url = "https://www.agendize.com/api/2.0/scheduling/"
var endPoint = "companies/13772899/widget/freeSlots?serviceId=13772901"

var text: String?
var availableSlots: JSON!
let formatter = NSDateFormatter()
let formatter2 = NSDateFormatter()
var collectionArray = [String]()
var checker = true
var checker2 = true

class CalendarVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var timesCollectionView: UICollectionView!
    
    @IBOutlet weak var calendar: FSCalendar!
    
 

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController!.setNavigationBarHidden(false, animated:true)
        self.navigationController?.navigationBar.barTintColor =  UIColor(red: 20/255.0, green: 157/255.0, blue: 234/255.0, alpha: 1.0)
        self.view.backgroundColor = UIColor(hue: 212/360, saturation: 7/100, brightness: 100/100, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        formatter.dateFormat = "yyyy-MM-dd"
        let calendar2 = NSCalendar.currentCalendar()
        let date = NSDate()
        let components = calendar2.components([.Year, .Month], fromDate: date)
        let startOfMonth = calendar2.dateFromComponents(components)!
        let start = formatter.stringFromDate(startOfMonth)
        print(start)
        let comps2 = NSDateComponents()
        comps2.month = 1
        comps2.day = -1
        let endOfMonth = calendar2.dateByAddingComponents(comps2, toDate: startOfMonth, options: [])!
        let end = formatter.stringFromDate(endOfMonth)
        print(end)
        freeSlots(start, endDate: end)
        
        
//        super.viewDidLoad()
//        self.navigationController!.setNavigationBarHidden(false, animated:true)
//        self.navigationController?.navigationBar.barTintColor =  UIColor(red: 20/255.0, green: 157/255.0, blue: 234/255.0, alpha: 1.0)
//        self.view.backgroundColor = UIColor(hue: 212/360, saturation: 7/100, brightness: 100/100, alpha: 1.0)
//        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
//        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
//        
//        
//        print("Calendar viewDidLoad")
////        print(MainViewController.service)
//        
//        
//        formatter.dateFormat = "yyyy-MM-dd"
//        let calendar2 = NSCalendar.currentCalendar()
//        let date = NSDate()
//        let components = calendar2.components([.Year, .Month], fromDate: date)
//        let startOfMonth = calendar2.dateFromComponents(components)!
//        let start = formatter.stringFromDate(startOfMonth)
//        print(start)
//        let comps2 = NSDateComponents()
//        comps2.month = 1
//        comps2.day = -1
//        let endOfMonth = calendar2.dateByAddingComponents(comps2, toDate: startOfMonth, options: [])!
//        let end = formatter.stringFromDate(endOfMonth)
//        print(end)
//        freeSlots(start, endDate: end)
        

      
    }
    
    
    func configureCalendar() {
        calendar.dataSource = self
        calendar.delegate = self
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0;
    }
    
    
    
    func calendar(calendar: FSCalendar, didSelectDate date: NSDate) {
        
        collectionArray.removeAll()
        formatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = formatter.stringFromDate(date)
        
        for (_, i) in availableSlots["items"] {
            if selectedDate == i["day"].stringValue {
                for (_, j) in i["slots"] {
                    collectionArray.append(j.stringValue)
                }
                self.timesCollectionView.reloadData()
                
                if checker2 {
                    self.timesCollectionView.dataSource = self
                    self.timesCollectionView.delegate = self
                    checker2 = false
                }
            }
        }
    }
    
    
    
    private func freeSlots(startDate: String, endDate: String) {
        Alamofire.request(.GET, "\(Url)\(endPoint)&startDate=\(startDate)&endDate=\(endDate)&token=\(sessionToken)&apiKey=\(APIKey)")
            .responseJSON { response in
                if response.result.isSuccess {
                    if let value = response.result.value {
                        availableSlots = JSON(value)
                        
                        if checker {
                            self.configureCalendar()
                            checker = false
                        }
                    }
                } else {
                    print("dumb shit")
                }
        }
    }
    
    
    
    func calendarCurrentMonthDidChange(calendar: FSCalendar) {
        let startOftheMonth = calendar.currentMonth
        formatter.dateFormat = "yyyy-MM-dd"
        let start = formatter.stringFromDate(startOftheMonth)
        print(start)
        let calendar2 = NSCalendar.currentCalendar()
        let comps2 = NSDateComponents()
        comps2.month = 1
        comps2.day = -1
        let endOfMonth = calendar2.dateByAddingComponents(comps2, toDate: startOftheMonth, options: [])!
        let end = formatter.stringFromDate(endOfMonth)
        print(end)
        
        freeSlots(start, endDate: end)
        
    }
    
    
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(collectionArray[indexPath.row])
    }
    
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = timesCollectionView.dequeueReusableCellWithReuseIdentifier("timesCollectionViewCell", forIndexPath: indexPath) as! timesCollectionViewCell
        let temp = collectionArray[indexPath.row].componentsSeparatedByString("T")
        let temp2 = temp[1].componentsSeparatedByString(":")
        
        if var realHour = Int(temp2[0]) {
            var hour = ""
            if realHour > 12 {
                realHour = realHour - 12
                hour = String(realHour) + ":" + temp2[1] + "pm"
            } else if realHour == 12 {
                hour = String(realHour) + ":" + temp2[1] + "pm"
            } else {
                hour = String(realHour) + ":" + temp2[1] + "am"
            }
            cell.layer.cornerRadius = 25
            cell.availableTimesLabel.text = hour
        }
        
        return cell
    }
    
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionArray.count
    }
    
    override func viewWillAppear(animated: Bool) {
        print("Calendar View will Appear")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
