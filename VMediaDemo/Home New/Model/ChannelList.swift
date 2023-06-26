//
//  ChannelList.swift
//  VMediaDemo
//
//  Created by Ravindra Arya on 6/25/20.
//

import Foundation

// MARK: - ChannelElement
struct ChannelElement: Codable {
    let orderNum, accessNum: Int
    let callSign: String
    let id: Int
    var programs : Program?

    enum CodingKeys: String, CodingKey {
        case orderNum, accessNum
        case callSign = "CallSign"
        case id
    }
}

typealias Channel = [ChannelElement]
