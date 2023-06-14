//
//  ChatViewModel.swift
//  ChatApp
//
//  Created by Nika Gogichashvili on 07.06.23.
//

import Foundation


final class ChatViewModel {
    
    private (set) var messages = [Message]() 

    let dbManager = CoreDataManager.shared
    
    func createMessage(id: Int, text: String, isSent: Bool, complition: @escaping() -> Void) {
        dbManager.saveMessage(id: id, text: text, date: getDate(), isSent: isSent)
        let newMessage = dbManager.fetchMessages().last
        if let message = newMessage {
            messages.append(message)
            print(messages)
            complition()
        }
    }
    
    func fetchMessage() {
        messages = dbManager.fetchMessages()
    }
    
    private func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, H:ss"
        let date = dateFormatter.string(from: Date())
        return date
    }
}
