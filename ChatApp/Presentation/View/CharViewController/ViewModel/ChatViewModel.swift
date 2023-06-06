//
//  ChatViewModel.swift
//  ChatApp
//
//  Created by MacBoobPro on 05.06.23.
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

    func createMessage(id: Int, text: String) {
        dbManager.saveMessage(id: id, text: text, date: getDate())
        let newMessage = dbManager.fetchMessages().last
        if let message = newMessage {
            messages.append(message)
            print(messages)
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
