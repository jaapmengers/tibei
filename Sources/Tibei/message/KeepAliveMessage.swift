//
//  KeepAliveMessage.swift
//  Pods
//
//  Created by DANIEL J OLIVEIRA on 12/7/16.
//
//

import Foundation

enum SystemMessages: Codable, MessageContent {
  case keepAliveMessage
  
  var type: String {
    switch self {
    case .keepAliveMessage: return "keepAliveMessage"
    }
  }
  
  enum CodingKeys: String, CodingKey {
    case type
    case value
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let type = try container.decode(String.self, forKey: CodingKeys.type)
    
    switch type {
    case "keepAliveMessage": self = .keepAliveMessage
    default: throw DecodingError.dataCorruptedError(forKey: CodingKeys.type, in: container, debugDescription: "Found unsupported type \(type)")
    }
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode("keepAliveMessage")
  }
}
