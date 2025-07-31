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
    let textBot: String
    let choices: [Choice]
}

enum StoryDestination: String, Hashable {
    case start
    case node1
    case node2
    case node3
    case node4
}
