//
//  NotificationManager.swift
//  chatlove
//
//  Created by Carla Araujo on 31/07/25.
//

import SwiftUI

class HapticManager {
    //singleton
    static let instance = HapticManager()
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType){
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle){
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
