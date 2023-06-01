//
//  Message+CoreDataProperties.swift
//  ChatApp
//
//  Created by MacBoobPro on 25.05.23.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var userId: Int16
    @NSManaged public var date: String?
    @NSManaged public var text: String?

}

extension Message : Identifiable {

}
