//
//  ChatViewModel.swift
//  ChatApp
//
//  Created by MacBoobPro on 07.06.23.
//

import Foundation


final class ChatViewModel {
    
    private (set) var messages = [Message]() {
        didSet {
            reloadTableView?()
        }
    }
    
    var reloadTableView:(() -> ())?
    let dbManager = CoreDataManager.shared
    let networkManager = NetworkManager.shared
    
    //    func createMessage(id: Int, text: String, isSent: Bool) {
    //        dbManager.saveMessage(id: id, text: text, date: getDate(), isSent: isSent)
    //        let newMessage = dbManager.fetchMessages().last
    //        if let message = newMessage {
    //            messages.append(message)
    //            print(messages)
    //        }
    //    }
    
    //    func createMessage(id: Int, text: String, isSent: Bool) {
    //        let newMessage = dbManager.saveMessage(id: id, text: text, date: getDate(), isSent: isSent)
    //        messages.append(newMessage)
    //        print(messages)
    //    }
    //
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
