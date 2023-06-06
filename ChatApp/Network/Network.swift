//
//  Network.swift
//  ChatApp
//
//  Created by MacBoobPro on 06.06.23.
//

import Foundation
import Network     

class Network {
    func isInternetAvailable() -> Bool {
        let monitor = NWPathMonitor()
        let semaphore = DispatchSemaphore(value: 0)
        var isAvailable = false

        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                isAvailable = true
            }
            semaphore.signal()
        }

        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)

        _ = semaphore.wait(timeout: .now() + 1)

        return isAvailable
    }
}
