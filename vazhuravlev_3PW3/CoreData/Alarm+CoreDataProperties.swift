//
//  Alarm+CoreDataProperties.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 21.03.2022.
//
//

import Foundation
import CoreData


extension Alarm {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Alarm> {
        return NSFetchRequest<Alarm>(entityName: "Alarm")
    }

    @NSManaged public var id: UUID
    @NSManaged public var hours: Int32
    @NSManaged public var minutes: Int32
    @NSManaged public var isActive: Bool
    @NSManaged public var sound: Int32

}

extension Alarm : Identifiable {

}
