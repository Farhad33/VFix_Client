//
//  UserVC.swift
//  VFix_ios
//
//  Created by Youcef Iratni on 4/12/16.
//  Copyright © 2016 Majid Rahimi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON



class UserVC: NSObject {
    
    private var sessionToken: String = "22719873bdbb43cf0cc7f77d6e857e9e"
    //    private var url: String = "companies/13772899/clients"
    private var APIKey: String = "f8d0c6b95ab7f5316a7bff112b40bfd2def192a0"
    private var baseUrl: String = "https://www.agendize.com/api/2.0/scheduling/clients"
    
    class var sharedManager: UserVC {
        struct Static {
            static let instance = UserVC()
        }
        return Static.instance
    }
    
    func NetworkRequest()  {
        Alamofire.request(.GET, "\(baseUrl)?apiKey=\(APIKey)&token=\(sessionToken)")
            
            .responseJSON { response in
                if let value = response.result.value {
                    let json = JSON(value)
                    let firstName = json["items"][0]["firstName"]
                    print(firstName)
                    //                    print(json)
                    
                    
                }
        }
    }
}
