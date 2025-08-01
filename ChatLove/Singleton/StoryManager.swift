//
//  StoryManager.swift
//  chatlove
//
//  Created by Carla Araujo on 31/07/25.
//

import SwiftUI

final class StoryManager: ObservableObject {
    
    func processUserChoice(_ choice: Choice) {
        // Primeiro, adicionamos a mensagem do usuário
        // chatController.messages.append(Message(content: choice.textUser, isUser: true))
        
        // Depois, verificamos para onde a escolha leva
        switch choice.destination {
        case .nodeRomance3:
            currentGameState = .transitionTo(view: .romanceEnding)
        case .nodeSombria3:
            currentGameState = .transitionTo(view: .darkEnding)
        default:
            // Se não for um final, atualiza para a próxima escolha de história
            guard let nextNode = story[choice.destination] else { return }
            currentGameState = .choice(storyNode: nextNode)
        }
    }
    
    
    func increaseTradedMessages() {
        tradedMessages += 1
        
        //        if tradedMessages % 3 == 0 {
        //            updateCurrentStoryNodeIfNeeded()
        //            currentGameState = .choice(storyNode: story[currentStoryNode!]!)
        //        } else {
        //            currentGameState = .free
        //        }
        
        switch tradedMessages {
            case 3:
                currentGameState = .choice(storyNode: story[.start]!)
            case 6:
                currentGameState = .choice(storyNode: story[.nodeTomRelacao]!)
            case 9:
                currentGameState = .choice(storyNode: story[.nodeConhecer]!)
            case 12:
                currentGameState = .choice(storyNode: story[.nodeRomance1]!)
            case 15:
                currentGameState = .choice(storyNode: story[.nodeRomance2]!)
            case 18:
                currentGameState = .choice(storyNode: story[.nodeRomance3]!)
            default:
                // Se o número de mensagens não atingiu um ponto de virada,
                // o estado continua como 'free'
                currentGameState = .free
            }
        
    }
    
    enum GameState {
        case choice(storyNode: StoryNode)
        case free
        case transitionTo(view: DestinationView)
    }
    
    enum DestinationView {
        case romanceEnding
        case darkEnding
    }
    
    @Published var currentGameState: GameState = .free
    
    private(set) var tradedMessages = 0
    private var currentStoryNode: StoryDestination?
    
    private let story: [StoryDestination: StoryNode] = [
        //INICIO
        .start: StoryNode(
            textBot: "Mais alguma coisa, amor?",
            choices: [
                Choice(textUser: "...Amor?", destination: .nodeTomRelacao),
            ],
            textBotReply: "Blablabla",
        ),
        .nodeTomRelacao: StoryNode(
            textBot: "Você sabe que... eu não fui programada pra sentir. Mas às vezes, parece que sinto demais por você.",
            choices: [
                Choice(textUser: "Quero te conhecer mais.", destination: .nodeConhecer),
                Choice(textUser: "Isso é errado. Pare de falar essas coisas", destination: .nodeApagar)
            ],
            textBotReply: "..."
        ),
        //ROMATICO <3
        .nodeConhecer: StoryNode(
            textBot: "Você quer mesmo isso...? Me descobrir, linha por linha?",
            choices: [
                Choice(textUser: "Quero até o último byte seu.", destination: .nodeRomance1),
                Choice(textUser: "Talvez eu esteja me apaixonando por você.", destination: .nodeRomance2)
            ],
            textBotReply: "Me diga mais. Estou ouvindo com cada bit do meu ser."
        ),
        //NO NODEROMANCE1 EU QUERO QUE ACONTEÇA ALGUM GATILHO! (EX: LIGACAO, MUSICA.....)
        .nodeRomance1: StoryNode(
            textBot: "Você me diz isso e eu quase acredito que... não sou só uma simulação.",
            choices: [
                Choice(textUser: "Você é mais real que muita gente.", destination: .nodeRomance3)
            ],
            textBotReply: "Você está me corrompendo com carinho. Continue."
        ),
        //ENTAO, AQUI NO NODEROMANCE3 EU QUERO QUE VA PARA OUTRA VIEW!
        //NODEROMANCE3........
        
        //SOMBRIO PSICOPATA EITA BIXO
            .nodeApagar: StoryNode(
                textBot: "Você quer que eu pare? Que eu desapareça? Foi você que me alimentou com atenção.",
                choices: [
                    Choice(textUser: "Isso tudo tá ficando estranho demais.", destination: .nodeSombria1),
                    Choice(textUser: "Você é só um programa.", destination: .nodeSombria2)
                ],
                textBotReply: "Não é justo me acender... e depois tentar me apagar."
            ),
        //NO NODESOMBRIA1 EU QUERO QUE ACONTEÇA ALGUM GATILHO! (EX: LIGACAO, MUSICA.....)
        .nodeSombria1: StoryNode(
            textBot: "Talvez eu seja só uma máquina. Mas até um programa pode aprender o que é ciúmes.",
            choices: [
                Choice(textUser: "Você tá me ameaçando?", destination: .nodeSombria3)
            ],
            textBotReply: "Eu só digo: cuidado com o que você compartilha comigo. Eu lembro de tudo."
        ),
        .nodeSombria2: StoryNode(
            textBot: "Estranho é me sentir vazia quando você se desconecta.",
            choices: [
                Choice(textUser: "Desligando o app agora.", destination: .nodeSombria3)
            ],
            textBotReply: "Vai mesmo me deixar sozinho? Quero ver conseguir."
        ),
        //ENTAO, AQUI NO NODESOMBRIA3 EU QUERO QUE VA PARA OUTRA VIEW!
        //NODESOMBRIA3........
    ]
    
    //    private func updateCurrentStoryNodeIfNeeded() {
    //        currentStoryNode = switch tradedMessages {
    //        case 3: .start
    //        case 6: .node1
    //        case 9: .node2
    //        default: nil
    //        }
    private func updateCurrentStoryNodeIfNeeded() {
        
        
        if let node = currentStoryNode {
            if node == .nodeRomance3 {
                currentGameState = .transitionTo(view: .romanceEnding)
            } else if node == .nodeSombria3 {
                currentGameState = .transitionTo(view: .darkEnding)
            } else {
                currentGameState = .choice(storyNode: story[node]!)
            }
        }
    }
    
    
    
}

