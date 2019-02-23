//
//  GameControllerService.swift
//  connectivityTest
//
//  Created by Daniel de Jesus Oliveira on 15/11/2016.
//  Copyright © 2016 Daniel de Jesus Oliveira. All rights reserved.
//

import Foundation
#if os(iOS) || os(watchOS) || os(tvOS)
import UIKit
#endif


class TibeiServer: NSObject, NetServiceDelegate {
    #if os(iOS) || os(watchOS) || os(tvOS)
    let deviceName: String = UIDevice.current.name
    #elseif os(OSX)
    let deviceName: String = Host.current().name ?? "<unknown>"
    #else
    let deviceName: String = "<unknown>"
    #endif
  
    let service: NetService
    
    let messenger: ServerMessenger
    
    init(messenger: ServerMessenger, serviceIdentifier: String) {
        self.messenger = messenger
        
        var serviceType = "\(serviceIdentifier)._tcp"
        
        if !serviceType.hasPrefix("_") {
            serviceType = "_\(serviceType)"
        }
        
        self.service = NetService(domain: "local", type: serviceType, name: self.deviceName)
        
        super.init()
    }
    
    func publishService() {
        self.service.includesPeerToPeer = true
        self.service.delegate = self
        self.service.publish(options: .listenForConnections)
    }
    
    func unpublishService() {
        self.service.stop()
    }
    
    // MARK: - NetServiceDelegate protocol
    // As opposed to the rest of the project, this method is inside the class definition instead
    // of inside an extension because otherwise, an @nonobjc attribute would be needed
    func netService(_ sender: NetService, didAcceptConnectionWith inputStream: InputStream, outputStream: OutputStream) {
        OperationQueue.main.addOperation {
            [weak self] in
            
            let newConnection = Connection(input: inputStream, output: outputStream)
            
            self?.messenger.addConnection(newConnection)
        }
    }
}
