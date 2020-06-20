//
//  Employee+CoreDataProperties.swift
//  EmployeeDirectory
//
//  Created by Nikhil B Kuriakose on 20/06/20.
//  Copyright © 2020 Nikhil. All rights reserved.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var emailAddress: String
    @NSManaged public var imageUrl: String?
    @NSManaged public var name: String
    @NSManaged public var phone: String?
    @NSManaged public var userName: String?
    @NSManaged public var website: String?
    @NSManaged public var address: Address?
    @NSManaged public var company: Company?

}
