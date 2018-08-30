//
//  ServiceLocator.swift
//  RedditTopListReader
//
//  Created by Andrei Pitsko on 8/30/18.
//  Copyright © 2018 Andrei Pitsko. All rights reserved.
//

import Foundation

// Helper class to erase type
private class BaseServiceContainer {}

private class ServiceContainer<T> : BaseServiceContainer {
    let service: T
    
    init(_ s: T) {
        service = s
    }
}

class ServiceLocator {
    
    private static let sharedInstance = ServiceLocator()
    
    private var services = [BaseServiceContainer]()
    
    // MARK: - Registering and Accessing Services
    internal class func registerService<T>(_ service: T) {
        ServiceLocator.sharedInstance.services.append(ServiceContainer<T>(service))
    }
    
    internal class func getService<T>() -> T {
        var result: T!
        for service in ServiceLocator.sharedInstance.services {
            if let container = service as? ServiceContainer<T> {
                result = container.service
                break
            }
        }
        if result == nil {
            assertionFailure("WARNING: no service \(T.self) found")
        }
        return result
    }
    
}
