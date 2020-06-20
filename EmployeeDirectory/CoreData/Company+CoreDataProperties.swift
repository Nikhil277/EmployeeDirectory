//
//  Company+CoreDataProperties.swift
//  EmployeeDirectory
//
//  Created by Nikhil B Kuriakose on 20/06/20.
//  Copyright © 2020 Nikhil. All rights reserved.
//
//

import Foundation
import CoreData


extension Company {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }

    @NSManaged public var bs: String?
    @NSManaged public var catchPhrase: String?
    @NSManaged public var name: String?
    @NSManaged public var employee: Employee?

}
