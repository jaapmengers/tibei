//
//  Message.swift
//  Tibei
//
//  Created by Daniel de Jesus Oliveira on 07/12/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import Tibei

enum Messages: Message {
  case textMessage(TextMessage)
  case pingMessage(PingMessage)
  
  enum CodingKeys: String, CodingKey {
    case type
    case value
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let type = try container.decode(String.self, forKey: CodingKeys.type)
    
    switch type {
    case "pingMessage": self = .pingMessage(try container.decode(PingMessage.self, forKey: CodingKeys.value))
    case "textMessage": self = .textMessage(try container.decode(TextMessage.self, forKey: CodingKeys.value))
    default: throw DecodingError.dataCorruptedError(forKey: CodingKeys.type, in: container, debugDescription: "Found unsupported type \(type) while decoding Messages")
    }
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    
    switch self {
    case .pingMessage(let pingMessage):
      try container.encode("pingMessage", forKey: CodingKeys.type)
      try container.encode(pingMessage, forKey: .value)
    case .textMessage(let textMessage):
      try container.encode("textMessage", forKey: CodingKeys.type)
      try container.encode(textMessage, forKey: .value)
    }
    
  }
}

struct TextMessage: Codable {
  let sender: String
  let content: String
}

struct PingMessage: Codable {
  let sender: String
}
