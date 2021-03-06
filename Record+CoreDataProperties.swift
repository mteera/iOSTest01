//
//  Record+CoreDataProperties.swift
//  iOSTest01
//
//  Created by Chace Teera on 18/09/2017.
//  Copyright © 2017 Beep!. All rights reserved.
//

import Foundation
import CoreData


extension Record {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Record> {
        return NSFetchRequest<Record>(entityName: "Record")
    }

    @NSManaged public var name: String?
    @NSManaged public var record_id: String?

}
