//
//  Message+CoreDataProperties.swift
//  ChatApp
//
//  Created by MacBoobPro on 05.06.23.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var userId: Int16
    @NSManaged public var text: String?
    @NSManaged public var date: String?

}

extension Message : Identifiable {

}
