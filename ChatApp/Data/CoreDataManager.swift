//
//  CoreDataManager.swift
//  ChatApp
//
//  Created by MacBoobPro on 25.05.23.
//

import Foundation
import CoreData

class CoreDataMannager {
    static let shared = CoreDataMannager()
    let context = AppDelegate.sharedAppDelegate.coreDataStack.managedContext

    func fetchMessages() -> [Message] {
        var messages = [Message]()
        do {
            let fetchRequest = NSFetchRequest<Message>(entityName: "Message")
            messages = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Failed to fetch messages: \(error)")
        }
        return messages
    }

    func saveMessage(id: Int, text: String, date: String) {
        let message = Message(context: context)
        message.userId = Int16(id)
        message.text = text
        message.date = date
        do {
            try context.save()
        } catch let error as NSError {
            print("Failed to save message: \(error)")
        }
    }
}
