//
//  ProgramList.swift
//  VMediaDemo
//
//  Created by Ravindra Arya on 25/06/23.
//

import Foundation

struct ProgramElement: Codable {
    let startTime: String
    let recentAirTime: RecentAirTime
    let length: Int
    let name: String
}

struct RecentAirTime: Codable {
    let id, channelID: Int
}

typealias Program = [ProgramElement]
