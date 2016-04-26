////
////  VfixClient.swift
////  VFix_ios
////
////  Created by Youcef Iratni on 4/12/16.
////  Copyright © 2016 Majid Rahimi. All rights reserved.
////
//
//import UIKit
//import Alamofire
//import SwiftyJSON
//
////let sessionToken = "22719873bdbb43cf0cc7f77d6e857e9e"
////let url = "companies/13772899/clients"
////let APIKey = "f8d0c6b95ab7f5316a7bff112b40bfd2def192a0"
////let baseUrl = NSURL(string: "https://www.agendize.com/api/2.0/scheduling/")
//
//
//private var Token: String = "22719873bdbb43cf0cc7f77d6e857e9e"
//private var Key: String = "f8d0c6b95ab7f5316a7bff112b40bfd2def192a0"
////private var Url: String = "https://www.agendize.com/api/2.0/scheduling/"
////private var endPoint: String = "companies/13772899/widget/freeSlots?serviceId=13772901"
//
//
//class VfixClient {
//
//    static var json: JSON!
//    static var freeSlots: JSON!
//    
//    class func NetworkRequest(endPoint: String)  {
//        Alamofire.request(.GET, "\(Url)\(endPoint)?apiKey=\(Key)&token=\(Token)")
//            .responseJSON { response in
//                
//                if response.result.isSuccess{
//                    if let value = response.result.value {
//                        json = JSON(value)
//                    }
//                }else{
//                    print("dumb shit")
//                }
//        }
//    }
//    
//    
//    
//    class func FreeSlots(startDate: String, endDate: String){
//        Alamofire.request(.GET, "\(Url)\(endPoint)&startDate=\(startDate)&endDate=\(endDate)&token=\(Token)&apiKey=\(Key)")
//            .responseJSON { response in
//                
//                if response.result.isSuccess{
//                    if let value = response.result.value {
//                        freeSlots = JSON(value)
//                        print(freeSlots)
//                    }
//                }else{
//                    print("dumb shit")
//                }
//        }
//    }
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
////    private var sessionToken: String = "22719873bdbb43cf0cc7f77d6e857e9e"
//////    private var url: String = "companies/13772899/clients"
////    private var APIKey: String = "f8d0c6b95ab7f5316a7bff112b40bfd2def192a0"
////    private var baseUrl: String = "https://www.agendize.com/api/2.0/scheduling/clients"
////    
////    class var sharedManager: VfixClient {
////        struct Static {
////            static let instance = VfixClient()
////        }
////        return Static.instance
////    }
////    
////    func NetworkRequest()  {
////        Alamofire.request(.GET, "\(baseUrl)?apiKey=\(APIKey)&token=\(sessionToken)")
////            
////            .responseJSON { response in
////                if let value = response.result.value {
////                    let json = JSON(value)
//////                    print(json)
////                    
////                    
////                }
////        }
////    }
//}
