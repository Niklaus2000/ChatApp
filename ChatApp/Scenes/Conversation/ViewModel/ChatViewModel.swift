//
//  ChatViewModel.swift
//  ChatApp
//
//  Created by Nika Gogichashvili on 07.06.23.
//

import Foundation

class ChatViewModel {
    
    private var messages: [Message] = []
    private let coreDataManager =  CoreDataManager.shared
    
    init() {
        messages = getAllMessages()
    }
    
    func getMessages(userID: Int) -> [Message] {
        messages.filter { isMessageValid(message: $0, userID: userID) }
    }
    
    func saveMessage(message: Message) {
        messages.append(message)
        coreDataManager.saveMessage(message: message)
    }
    
    private func getAllMessages() -> [Message] {
        coreDataManager.fetchMessages()
    }
    
    private func isMessageValid (message: Message, userID: Int) -> Bool {
        !message.isSent || message.userId == userID
    }
}

