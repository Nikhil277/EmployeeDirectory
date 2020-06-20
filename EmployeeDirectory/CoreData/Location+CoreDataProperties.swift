//
//  Location+CoreDataProperties.swift
//  EmployeeDirectory
//
//  Created by Nikhil B Kuriakose on 20/06/20.
//  Copyright © 2020 Nikhil. All rights reserved.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var lat: Double
    @NSManaged public var long: Double
    @NSManaged public var coordinates: Address?

}
