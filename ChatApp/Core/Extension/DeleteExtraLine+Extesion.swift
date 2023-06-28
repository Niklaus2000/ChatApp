//
//  DeleteExtraLine+Extesion.swift
//  ChatApp
//
//  Created by Nika Gogichashvili on 28.06.23.
//

import Foundation

extension String {
    func processTextAndSendMessage() -> String {
         let trimmedText = trimmingCharacters(in: .whitespacesAndNewlines)
         let lines = trimmedText.components(separatedBy: "\n")
         let nonEmptyLines = lines.filter{ !$0.isEmpty }
         let finalText = nonEmptyLines.joined(separator: "\n")
        
        return finalText
     }
}


