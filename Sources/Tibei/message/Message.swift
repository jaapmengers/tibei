//
//  Message.swift
//  Tibei-iOS
//
//  Created by Jaap Mengers on 23/02/2019.
//

import Foundation

public protocol Message: Codable {
  var type: String { get }
}
