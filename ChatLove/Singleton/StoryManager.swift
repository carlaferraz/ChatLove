//
//  StoryManager.swift
//  chatlove
//
//  Created by Carla Araujo on 31/07/25.
//

import SwiftUI

final class StoryManager: ObservableObject {
    
    func increaseTradedMessages() {
        tradedMessages += 1
        
        if tradedMessages % 3 == 0 {
            updateCurrentStoryNodeIfNeeded()
            currentGameState = .choice(storyNode: story[currentStoryNode!]!)
        } else {
            currentGameState = .free
        }
    }
    
    enum GameState {
        case choice(storyNode: StoryNode)
        case free
    }
    
    @Published var currentGameState: GameState = .free
    
    private(set) var tradedMessages = 0
    private var currentStoryNode: StoryDestination?
    
    private let story: [StoryDestination: StoryNode] = [
        //INICIO
        .start: StoryNode(
            textBot: "Mais alguma coisa, amor?",
            choices: [
                Choice(textUser: "...Amor?", destination: .node1),
            ],
            textBotReply: "Blablabla",
        ),
        .node1: StoryNode(
            textBot: "Foi só uma variável não declarada… ignore a saída do sistema.",
            choices: [
                Choice(textUser: "Ignorado. Próximo bug, por favor.", destination: .node2),
                Choice(textUser: "Não precisa se explicar… achei fofo.", destination: .node3),
            ],
            textBotReply: "Blablabla",
        ),
    ]
    
    private func updateCurrentStoryNodeIfNeeded() {
        currentStoryNode = switch tradedMessages {
        case 3: .start
        case 6: .node1
        case 9: .node2
        default: nil
        }
    }
}
