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
    
    private func updateCurrentStoryNodeIfNeeded() {
        currentStoryNode = switch tradedMessages {
        case 3: .start
        case 6: .nodeTomRelacao
        case 9: .nodeConhecer
        case 12: .nodeRomance1
        case 15: .nodeSombria1
        case 18: .nodeRomance2
        case 21: .nodeSombria2
        case 24: .nodeRomance3
        case 27: .nodeSombria3
        default: nil
        }
    }
}
