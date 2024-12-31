//
//  eventModel.swift
//  orizinal
//
//  Created by Haru Takenaka on 2024/12/15.
//

import Foundation

struct All: Codable {
  var days: [Day]
}

struct Day: Codable {
  var date: Date
  var events: [Event]
}

struct Event: Codable {
  var content: String
  var time: Date
  var color: String
}

