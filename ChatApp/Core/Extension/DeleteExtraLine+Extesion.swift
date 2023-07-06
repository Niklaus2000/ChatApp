//
//  DeleteExtraLine+Extesion.swift
//  ChatApp
//
//  Created by Nika Gogichashvili on 28.06.23.
//

import Foundation

extension String {
    var withoutWhiteSpaces: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n")
            .filter { !$0.isEmpty }
            .joined(separator: "\n")
    }
}



