//
//  MessageReceiver.swift
//  Pods
//
//  Created by Daniel de Jesus Oliveira on 27/12/2016.
//
//

import Foundation

/**
 Represents an entity that responds to received messages. It can explicitly state which types of messages it expects, and will only be prompted to process a message if appropriated.
 */
public protocol ConnectionResponder: class {
  
    /**
     Processes a message that was received through an active connection.
     
     - Parameters:
        - message: The message received through the connection
        - connectionID: The identifier of the connection that received the message
     */
    func processMessage(_ data: Data, fromConnectionWithID connectionID: ConnectionID)
    /**
     Notifies the responder that a connection has been accepted
     
     - Parameter connectionID: The identifier of the accepted connection
     */
    func acceptedConnection(withID connectionID: ConnectionID)
    /**
     Notifies the responder that a connection has been lost
     
     - Parameter connectionID: The identifier of the lost connection
     */
    func lostConnection(withID connectionID: ConnectionID)
    /**
     Processes an error that occurred while handling an active connection
     
     - Parameters:
        - error: The error that occurred.
        - connectionID: The identifier of the connection that raised the error.
     */
    func processError(_ error: Error, fromConnectionWithID connectionID: ConnectionID?)
}

public extension ConnectionResponder {
  /// :nodoc:
  func processMessage(_ data: Data, fromConnectionWithID connectionID: ConnectionID) {
  }
  
  /// :nodoc:
  func acceptedConnection(withID connectionID: ConnectionID) {
  }
  
  /// :nodoc:
  func lostConnection(withID connectionID: ConnectionID) {
  }
  
  /// :nodoc:
  func processError(_ error: Error, fromConnectionWithID connectionID: ConnectionID?) {
  }
}
