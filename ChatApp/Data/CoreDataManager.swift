//
//  CoreDataManager.swift
//  ChatApp
//
//  Created by MacBoobPro on 07.06.23.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
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

    func saveMessage(id: Int, text: String, date: String, isSent: Bool) {
        let message = Message(context: context)
        
        message.userId = Int16(id)
        message.text = text
        message.date = date
        message.isSent = isSent
        do {
            try context.save()
            print("addd")
        } catch let error as NSError {
            print("Failed to save message: \(error)")
        }
    }
}
