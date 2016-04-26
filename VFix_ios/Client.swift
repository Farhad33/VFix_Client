


import Foundation


struct Client {
    
    var firstName: String = ""
    var lastName: String = ""
    var phone: String = ""
    var email: String = ""
    var street: String = ""
    var city: String = ""
    var state: String = "California"
    var country: String = "US"
    var zipCode: String = ""
    var timeZone: String = "US/Pacific"
    
    
    var ValidAll: Bool {
        guard firstName != "" &&
              lastName != "" &&
              phone != "" &&
              email != "" &&
              street != "" &&
              city != "" &&
              zipCode != ""
            else {
            return false
        }
        return true
    }
    
    
    //    var phoneNumberValid: Bool {
    //return self.phoneNumber?.areAllNumbers()
    //    }
    
    
    
    var serializedJSONClient: [String: AnyObject] {
        var json: [String: AnyObject] = [:]
        
        json = ["firstName": firstName, "lastName": lastName, "phone": phone, "email": email, "timeZone": timeZone,
                "address": ["street": street, "city": city, "state": state, "country": country, "zipCode": zipCode] ]
        
        return json
    }
    
    
    
    
    
    
}
