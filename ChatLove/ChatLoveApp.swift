//
//  chatloveApp.swift
//  chatlove
//
//  Created by Carla Araujo on 30/07/25.
//

import SwiftUI

@main
struct chatloveApp: App {
    var body: some Scene {
        WindowGroup {
//            ContentView(isFocused: false)
//            HomeView()
//                .environmentObject(StoryManager())
//            CallView()
            TerminalView()
        }
    }
}
