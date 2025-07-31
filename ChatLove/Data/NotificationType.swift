//
//  NotificationType.swift
//  chatlove
//
//  Created by Carla Araujo on 30/07/25.
//

import Foundation

enum NotificationType: String {
    case friendly = "friendlyNotification"
    case obsessive = "obsessiveNotification"
    
    var title: String{
        switch self{
        case .friendly:
            return "Ei, volta aqui!"
        case .obsessive:
            return "Eu sei onde você está"
        }
    }
    
    var body: String{
        switch self{
        case .friendly:
            return "Senti sua falta."
        case .obsessive:
            return "Você não respondeu. Não gostei disso."
        }
    }
}
