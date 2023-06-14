//
//  Network.swift
//  ChatApp
//
//  Created by Nika Gogichashvili on 07.06.23.
//

import Network

final class NetworkManager {
    
    static  let shared = NetworkManager()
    
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
