//
//  EmployeeModel.swift
//  EmployeeDirectory
//
//  Created by Nikhil B Kuriakose on 20/06/20.
//  Copyright © 2020 Nikhil. All rights reserved.
//

import Foundation

class EmployeeModel: NSObject {
    
    var id = ""
    var name = ""
    var username = ""
    var email = ""
    var profile_image = ""
    var phone = ""
    var website = ""
    var address = AddressModel()
    var company = CompanyModel()
    
    init(_ dictionary: [String: AnyObject]) {
        id = Utils.sharedInstance.getStringValue("id", dictionary: dictionary)
        name = Utils.sharedInstance.getStringValue("name", dictionary: dictionary)
        username = Utils.sharedInstance.getStringValue("username", dictionary: dictionary)
        email = Utils.sharedInstance.getStringValue("email", dictionary: dictionary)
        profile_image = Utils.sharedInstance.getStringValue("profile_image", dictionary: dictionary)
        phone = Utils.sharedInstance.getStringValue("phone", dictionary: dictionary)
        website = Utils.sharedInstance.getStringValue("website", dictionary: dictionary)
        if let addressDetails = dictionary["address"] as? [String : AnyObject] {
            address = AddressModel(addressDetails)
        }
        if let companyDetails = dictionary["company"] as? [String : AnyObject] {
            company = CompanyModel(companyDetails)
        }
    }
    
}


class AddressModel: NSObject {
    
    var street = ""
    var suite = ""
    var city = ""
    var zipcode = ""
    var geo = LocationModel()
    
    init(_ dictionaryData: [String: AnyObject]? = nil) {
        if let dictionary = dictionaryData {
            street = Utils.sharedInstance.getStringValue("street", dictionary: dictionary)
            suite = Utils.sharedInstance.getStringValue("suite", dictionary: dictionary)
            city = Utils.sharedInstance.getStringValue("city", dictionary: dictionary)
            zipcode = Utils.sharedInstance.getStringValue("zipcode", dictionary: dictionary)
            if let geoDetails = dictionary["geo"] as? [String : AnyObject] {
                geo = LocationModel(geoDetails)
            }
        }
    }
}


class LocationModel: NSObject {
    
    var lat = ""
    var lng = ""
    
    init(_ dictionaryData: [String: AnyObject]? = nil) {
        if let dictionary = dictionaryData {
            lat = Utils.sharedInstance.getStringValue("lat", dictionary: dictionary)
            lng = Utils.sharedInstance.getStringValue("lng", dictionary: dictionary)
        }
    }
}


class CompanyModel: NSObject {
    
    var name = ""
    var catchPhrase = ""
    var bs = ""
    
    init(_ dictionaryData: [String: AnyObject]? = nil) {
        if let dictionary = dictionaryData {
            name = Utils.sharedInstance.getStringValue("name", dictionary: dictionary)
            catchPhrase = Utils.sharedInstance.getStringValue("catchPhrase", dictionary: dictionary)
            bs = Utils.sharedInstance.getStringValue("bs", dictionary: dictionary)
        }
    }
}
