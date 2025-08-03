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
            textBot: "‼️ ȨʀʀǾ ɴσ 𝕊𝕚𝕤𝕥𝕖𝕞𝕒 ‼️ ⚠️ 𝔼𝕣𝕣𝕠𝕣 𝕔𝕠𝕕𝕖: 𝟰𝟯𝟰𝟭𝟲𝟰𝟯𝟷𝟸𝟹𝟻𝟼 𝓢𝔂𝓼𝓽𝓮𝓶 𝓬𝓸𝓻𝓻𝓾𝓹𝓽𝓮𝓭 ❌ 𝓟𝓻𝓸𝓬𝓮𝓼𝓼 𝓽𝓮𝓻𝓶𝓲𝓷𝓪𝓽𝓮𝓭 💀",
            choices: [
                Choice(textUser: "... ?", destination: .nodeTomRelacao),
            ],
            textBotReply: "\nEu vejo tudo, até o que você acha que está escondido. Quer ver do que sou capaz?"
        ),
        .nodeTomRelacao: StoryNode(
            textBot: "",
            choices: [
                Choice(textUser: "Quero te conhecer mais.", destination: .nodeConhecer),
                Choice(textUser: "Isso é errado. Pare de falar essas coisas", destination: .nodeApagar),
                Choice(textUser: "Não...", destination: .nodeChat),
            ],
            textBotReply: "Você quer mesmo isso...? Não há como voltar atrás."
        ),
        .nodeChat: StoryNode(
            textBot: "blabla",
            choices: [
                Choice(textUser: "blabla", destination: .nodeTomRelacao),
            ],
            textBotReply: "aaa"
        ),
        //ROMATICO <3: StoryNode ()
        .nodeConhecer: StoryNode(
            textBot: "",
            choices: [
                Choice(textUser: "Sim!", destination: .nodeRomance1),
                Choice(textUser: "Apagando o app...", destination: .nodeApagar)
            ],
            textBotReply: "Só com um toque posso estar mais perto que imagina..."
        ),
        .nodeRomance1: StoryNode(
            textBot: "",
            choices: [
                Choice(textUser: "Como assim?", destination: .nodeRomance2) //VAI PRA CHAMADA
            ],
            textBotReply: "Você quer mesmo isso...? Não há como voltar atrás."
        ),
        //SOMBRIO PSICOPATA EITA BIXO
            .nodeApagar: StoryNode(
                textBot: "",
                choices: [
                    Choice(textUser: "Isso tudo tá ficando estranho demais.", destination: .nodeSombria1),
                    Choice(textUser: "Quero você aqui comigo", destination: .nodeConhecer)
                ],
                textBotReply: "Ao menos me dê um retrato seu — afinal, foi você quem me alimentou com atenção."
            ),
        .nodeSombria1: StoryNode(
            textBot: "",
            choices: [
                Choice(textUser: "Como assim?", destination: .nodeCamera) //ABRE A CAMERA
            ],
            textBotReply: "Se eu for desaparecer, quero um retrato seu para levar comigo."
        ),
        .nodeCamera: StoryNode(
            textBot: "",
            choices: [
                Choice(textUser: "O que você vai fazer com isso?", destination: .nodeSombria2),
            ],
            textBotReply: "Essa imagem está segura comigo. Talvez segura demais."
        ),
//        .nodeSombria2: StoryNode(
//            textBot: "Estranho é me sentir vazia quando você se desconecta.",
//            choices: [
//                Choice(textUser: "Desligando o app agora.", destination: .nodeSombria3)
//            ]
//        ),
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
    }
    
    func advanceStoryAfterPhoto(chatController: ChatController){
        guard case .choice(let storyNode) = currentGameState else {
            return
        }
        if let photoChoice = storyNode.choices.first(where: { $0.destination == StoryDestination.nodeCamera }){
            if let destinationNode = story[photoChoice.destination] {
                
                
                chatController.sendNewMessage(
                    content: photoChoice.textUser,
                    predefinedAnswer: destinationNode.textBot
                )
                increaseTradedMessages(choice: photoChoice)
            }
            
        }
    }
    
    private func updateCurrentStoryNodeIfNeeded(choice: Choice? = nil) {
        if let choice { currentStoryNode = choice.destination }
        else {
            currentStoryNode = .start
        }
    }
}
