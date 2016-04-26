


import Foundation


struct Appointment {
    
    var id: String?
    var dateTime: String?
    var timeZone: String = "US/Pacific"
    var service: String?
    var message: String?
    
    
    var serviceValidation: Bool {
        return service != nil
    }
    
    
    var IdValidation: Bool {
        return id != nil
    }
    
    
    var dateValidation: Bool {
        return dateTime != nil
    }
    
    
    //    var phoneNumberValid: Bool {
    //return self.phoneNumber?.areAllNumbers()
    //    }
    
    
    var serializedJSONAppointment: [String: AnyObject] {
        var json: [String: AnyObject] = [:]
        
        json["client"] = ["id": id!]
        
        if let text = message {
            json["form"] = ["value": text]
        }
        
        json["service"] = ["id": service!]
        
        json["start"] = ["dateTime": dateTime!, "timeZone": timeZone ]
        
        return json
    }
    
    
    
    
    
    
    
}
