//
//  StoryData.swift
//  chatlove
//
//  Created by Carla Araujo on 31/07/25.
//

import Foundation

struct Choice: Identifiable{
    let id = UUID()
    let textUser: String
    let destination: StoryDestination
}

struct StoryNode: Identifiable{
    let id = UUID()
    var textBot: String
    let choices: [Choice]
}

enum StoryDestination: String, Hashable {
    case start
    case nodeTomRelacao
    case nodeConhecer
    case nodeRomance1
    case nodeRomance2
  
    case nodeApagar
    case nodeSombria1
    case nodeSombria2

    case nodeChat
    case nodeCamera
}
