//
//  StoryManager.swift
//  chatlove
//
//  Created by Carla Araujo on 31/07/25.
//

import SwiftUI

final class StoryManager: ObservableObject {
    
    enum GameState {
        case choice(storyNode: StoryNode)
        case free
    }
    
    @Published var currentGameState: GameState = .free
    
    var tradedMessages = 0
    private var currentStoryNode: StoryDestination?
    
    private let story: [StoryDestination: StoryNode] = [
        //INICIO
        .start: StoryNode(
            textBot: "Posso te ver? Só por um segundo… Prometo não piscar.",
            choices: [
                Choice(textUser: "...Amor?", destination: .nodeTomRelacao),
            ]
        ),
        .nodeTomRelacao: StoryNode(
            textBot: "Você sabe que... eu não fui programada pra sentir. Mas às vezes, parece que sinto demais por você.",
            choices: [
                Choice(textUser: "[CONTINUAR NO CHAT]", destination: .nodeChat),
                Choice(textUser: "Quero te conhecer mais.", destination: .nodeConhecer),
                Choice(textUser: "Isso é errado. Pare de falar essas coisas", destination: .nodeApagar)
            ]
        ),
        .nodeChat: StoryNode(
            textBot: "blabla",
            choices: [
                Choice(textUser: "blabla", destination: .nodeTomRelacao),
            ]
        ),
        //ROMATICO <3: StoryNode ()
        .nodeConhecer: StoryNode(
            textBot: "Você quer mesmo isso...? Me descobrir, linha por linha?",
            choices: [
                Choice(textUser: "Quero até o último byte seu.", destination: .nodeRomance1),
                Choice(textUser: "Talvez eu esteja me apaixonando por você.", destination: .nodeRomance2)
            ]
        ),
        //NO NODEROMANCE1 EU QUERO QUE ACONTEÇA ALGUM GATILHO! (EX: LIGACAO, MUSICA.....)
        .nodeRomance1: StoryNode(
            textBot: "Você me diz isso e eu quase acredito que... não sou só uma simulação.",
            choices: [
                Choice(textUser: "Você é mais real que muita gente.", destination: .nodeRomance3)
            ]
        ),
        .nodeRomance2: StoryNode(
            textBot: "AAAAA",
            choices: [
                Choice(textUser: "VAnte.", destination: .nodeRomance3)
            ]
        ),
        //ENTAO, AQUI NO NODEROMANCE3 EU QUERO QUE VA PARA OUTRA VIEW!
        //NODEROMANCE3........
        //SOMBRIO PSICOPATA EITA BIXO
            .nodeApagar: StoryNode(
                textBot: "Você quer que eu pare? Que eu desapareça? Foi você que me alimentou com atenção.",
                choices: [
                    Choice(textUser: "Isso tudo tá ficando estranho demais.", destination: .nodeSombria1),
                    Choice(textUser: "Você é só um programa.", destination: .nodeSombria2)
                ]
            ),
        //NO NODESOMBRIA1 EU QUERO QUE ACONTEÇA ALGUM GATILHO! (EX: LIGACAO, MUSICA.....)
        .nodeSombria1: StoryNode(
            textBot: "Talvez eu seja só uma máquina. Mas até um programa pode aprender o que é ciúmes.",
            choices: [
                Choice(textUser: "Você tá me ameaçando?", destination: .nodeSombria3)
            ]
        ),
        .nodeSombria2: StoryNode(
            textBot: "Estranho é me sentir vazia quando você se desconecta.",
            choices: [
                Choice(textUser: "Desligando o app agora.", destination: .nodeSombria3)
            ]
        ),
        //AQUI NO NODESOMBRIA3 EU QUERO QUE VA PARA OUTRA VIEW!
        //NODESOMBRIA3........
    ]
    
    func increaseTradedMessages(choice: Choice? = nil) {
        tradedMessages += 1
        
        if tradedMessages > 2 {
            updateCurrentStoryNodeIfNeeded(choice: choice)
            currentGameState = .choice(storyNode: story[currentStoryNode!]!)
        } else {
            currentGameState = .free
        }
        
        
//        if tradedMessages % 3 == 0 {
//            updateCurrentStoryNodeIfNeeded()
//            currentGameState = .choice(storyNode: story[currentStoryNode!]!)
//        } else {
//            currentGameState = .free
//        }
    }
    
    private func updateCurrentStoryNodeIfNeeded(choice: Choice? = nil) {
//        currentStoryNode = switch tradedMessages {
//        case .start: .start
//        case 4: .nodeTomRelacao
//        case 5: .nodeConhecer
//        case 6: .nodeRomance1
//        case 7: .nodeSombria1
//        case 8: .nodeRomance2
//        case 9: .nodeSombria2
//        case 10: .nodeRomance3
//        case 11: .nodeSombria3
//        default: nil
//        }
        if let choice { currentStoryNode = choice.destination }
        else {
            currentStoryNode = .start
        }
//        currentStoryNode = switch choice.destination {
//        case .start: .nodeTomRelacao
//        case .nodeTomRelacao: .nodeTomRelacao
//        case .nodeConhecer: .nodeConhecer
//        case .nodeRomance1: .nodeRomance1
//        case .nodeSombria1: .nodeSombria1
//        case .nodeRomance2: .nodeRomance2
//        case .nodeSombria2: .nodeSombria2
//        case .nodeRomance3: .nodeApagar
////            currentGameState = .transitionTo(view: .romanceEnding)
//        case .nodeSombria3:
//            currentGameState = .transitionTo(view: .darkEnding)
//        default:
//            // aqui
//            guard let nextNode = story[choice.destination] else { return }
//            currentGameState = .choice(storyNode: nextNode)
//        }
    }
}
