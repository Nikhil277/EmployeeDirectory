//
//  Utils.swift
//  EmployeeDirectory
//
//  Created by Nikhil B Kuriakose on 20/06/20.
//  Copyright © 2020 Nikhil. All rights reserved.
//

import Foundation
import UIKit


class Utils: NSObject {
    
    static let sharedInstance = Utils()
    private override init() {}
    
   
    public func getDictionaryFromJson (string: String) -> [String: AnyObject]? {
        if let data = string.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
            } catch {
                
            }
        }
        return nil
    }
    
    func getStringValue(_ key : String , dictionary : [String : AnyObject]) -> String {
        var theValue = ""
        if let stringValue = dictionary[key] as? String {
            theValue = stringValue
        }
        else if let intValue = dictionary[key] as? Int {
            theValue = String(intValue)
        }
        
        return theValue
    }
    
    func getIntegerValue(_ key : String , dictionary : [String : AnyObject]) -> Int {
        var theValue = 0
        if let stringValue = dictionary[key] as? String {
            theValue = Int(stringValue) ?? 0
        }
        else if let intValue = dictionary[key] as? Int {
            theValue = intValue
        }
        
        return theValue
    }
    
}





