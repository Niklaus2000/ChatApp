//
//  CoreDataManager.swift
//  ChatApp
//
//  Created by Nika Gogichashvili on 07.06.23.
//

import Foundation
import CoreData

final class CoreDataManager {
    // MARK: Properties
    static let shared = CoreDataManager()
    let context = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
    
    // MARK: Methods
    func fetchMessages() -> [Message] {
        var message = [Message]()
        do {
            let fetchRequest = NSFetchRequest<MessageEntity>(entityName: "MessageEntity")
            let messages = try context.fetch(fetchRequest)
            message = messages.map {
                Message(
                    userId: Int($0.userId),
                    text: $0.text ?? "",
                    date: $0.date ?? Date(),
                    isSent: $0.isSent)
                
            }
        } catch let error as NSError {
            print("Failed to fetch messages: \(error)")
        }
        return message
    }
    
    func saveMessage(message: Message) {
        let entity = MessageEntity(context: context)
        entity.userId = Int16(message.userId)
        entity.text = message.text
        entity.date = message.date
        entity.isSent = message.isSent
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Failed to save message: \(error)")
        }
    }
}
