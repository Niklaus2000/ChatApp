//
//  Date+Extension.swift
//  ChatApp
//
//  Created by Nika Gogichashvili on 25.06.23.
//

import Foundation

extension Date {
    func formaDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, H:ss"
        let date = dateFormatter.string(from: Date())
        return date
    }
}
 
