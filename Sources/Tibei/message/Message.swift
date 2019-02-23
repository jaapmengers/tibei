//
//  Message.swift
//  Tibei-iOS
//
//  Created by Jaap Mengers on 23/02/2019.
//

import Foundation

public protocol MessageContent: Codable {
  var type: String { get }
}

public protocol AnyMessage: Codable { }

public struct Message<T: MessageContent>: AnyMessage {
  public let value: T
  
  public init(value: T) {
      self.value = value
  }
  
  var type: String {
    get {
      return value.type
    }
  }
  
  enum CodingKeys: String, CodingKey {
    case type
    case value
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    self.value = try container.decode(T.self)
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(self.value, forKey: CodingKeys.value)
    try container.encode(self.type, forKey: CodingKeys.type)
  }
}
