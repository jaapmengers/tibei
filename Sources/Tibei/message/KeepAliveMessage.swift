//
//  KeepAliveMessage.swift
//  Pods
//
//  Created by DANIEL J OLIVEIRA on 12/7/16.
//
//

import Foundation

enum SystemMessages: Message {
  case keepAliveMessage
  
  enum CodingKeys: String, CodingKey {
    case type
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let type = try container.decode(String.self, forKey: .type)
    switch type {
      case "keepAliveMessage": self = .keepAliveMessage
      default: throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Found unsupported type \(type)")
    }
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode("keepAliveMessage", forKey: .type)
  }
}
