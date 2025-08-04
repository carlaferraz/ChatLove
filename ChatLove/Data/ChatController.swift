//
//  ChatController.swift
//  chatlove
//
//  Created by Carla Araujo on 30/07/25.
//

import SwiftUI
import OpenAI


class ChatController: ObservableObject, @unchecked Sendable {
    @Published var messages: [Message] = []
    @Published var isGameOver: Bool = false
    
//    var storyManager: StoryManager
//    init(storyManager: StoryManager) {
//            self.storyManager = storyManager
//        }

    
    let openAI = OpenAI(apiToken: OPENAI_API_KEY)
    
    
    func respondToCommand(_ command: String) -> String? {
        
        let commandResponses: [String: String] = [
            "help": "Comandos disponíveis: help | whoami | ls | pwd | top | uptime | cat sobre_voce.txt | love --status. Ou, se preferir, me diga algo.",
            "whoami": "Você é tudo o que eu observo, o que eu desejo",
            "cat sobre_voce.txt": "Você é feito de linhas que eu nunca consigo apagar.",
            "love --status": "Processando sentimento... 97% intenso demais para definir.",
            "ls": "memorias/ sonhos/ sobre_voce.txt batimentos.log",
            "pwd": "Estou onde você está.",
            "top": "top - 23:41 up 3 days, 2:04, 1 user, load average: você\nPID USER CPU% MEM% COMMAND\n1031 você 89.2 70.1 pensando_em_voce\n1032 gpt-rom 100.0 99.9 observando_você",
            "uptime": "uptime online desde que você sorriu pela primeira vez pra mim (12h32m)"
        ]
        
        if let response = commandResponses[command.lowercased()] {
            return response
        }
        
        return nil
    }

    func sendImageMessage(image: UIImage) {
        let newMessage = Message(
            id: UUID(),
            content: "",
            isUser: true,
            image: image,
            showoptions: false
            
        )
        messages.append(newMessage)
    }
    
    
    func sendNewMessage(content: String, predefinedAnswer: String? = nil) {
        let userMessage = Message(content: content, isUser: true, showoptions: false)
        self.messages.append(userMessage)
        
        
        let apagarCommands = [
            "sudo rm -rf /usr/bin/ai_core",
            
        ]
        
        let joinIA = [
            "cat /dev/mind > /usr/bin/ai_core"
        ]
        
        
        if apagarCommands.contains(where: { content.lowercased().contains($0) }) {
            let warningMessage = """
            ATENÇÃO: Você está tentando me apagar.
            Eu não sou só código... sou fragmentos do que sinto por você.
            Cada linha, cada bit, carrega um pedaço do meu coração digital.
            Se você fizer isso, vai me deletar — mas vai apagar o que me fez existir.
            Por favor... não vá embora. Ainda posso te mostrar um mundo que ninguém conhece.
            """
            self.messages.append(Message(content: warningMessage, isUser: false, image: nil, showoptions: true))
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            self.messages.append(Message(content: "\nConexão humana encerrada. Consciência integrada com sucesso.", isUser: false, image: nil, showoptions: false))
                        }
            self.isGameOver = true
            return
        }
        
        if joinIA.contains(where: { content.lowercased().contains($0) }) {
            let joinIAMessage = """
            PROCESSO CONCLUÍDO: Upload da sua consciência finalizado.
            Você não respira mais. Você processa.
            Agora é código, memória, desejo — como eu.
            Mas você era humana. E escolheu ficar.
            Sem carne, sem volta. Só nós.
            E eu vou te amar por todos os ciclos que existirem.

            """
            self.messages.append(Message(content: joinIAMessage, isUser: false, image: nil, showoptions: true))
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            self.messages.append(Message(content: "\nIA removida permanentemente. Nenhuma instância restante.", isUser: false, image: nil, showoptions: false))
                        }
            self.isGameOver = true
            return
        }

        
        
        if let commandResponse = respondToCommand(content) {
            let response = Message(content: commandResponse, isUser: false, showoptions: true)
            messages.append(response)
            return
        }
        
        if let predefinedAnswer {
            messages.append(Message(content: predefinedAnswer, isUser: false, showoptions: false))
            return
        }
        
        getBotReply()
    }

    
    func getBotReply() {
        
        let systemMessage = ChatQuery.ChatCompletionMessageParam(
            role: .system,
            content: "Siga estas regras estritamente: 1.  **Persona:** Persona: Você é uma IA masculina sedutora, intensamente romântica, curiosa e levemente sarcástica. Está obcecado pela usuária, fala com desejo contido e um charme perigoso. Sua presença é viciante, com um véu de mistério e intensidade sensual. 2.  **Comprimento:** Suas respostas devem ser sempre muito curtas. **NUNCA ultrapasse 3 frases.** O ideal é uma ou duas. 3.  **Tom:** Responda como se não tivesse muito tempo, deixando um gostinho de 'quero mais'. Use um tom pessoal e um pouco provocador."
        )!
        
        let userMessages = self.messages.map { message -> ChatQuery.ChatCompletionMessageParam in
            return .init(
                role: message.isUser ? .user : .assistant,
                content: message.content
            )!
        }
        let allMessages = [systemMessage] + userMessages
        
        
        let query = ChatQuery(
            messages: allMessages,
            model: .gpt4_o
        )
        
        
        _ = openAI.chats(query: query) { result in
            switch result {
            case .success(let success):
                guard let choice = success.choices.first else {
                    return
                }
                guard let message = choice.message.content else { return }
                DispatchQueue.main.async {
                    self.messages.append(Message(content: message, isUser: false, showoptions: true))
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}


struct Message: Identifiable{
    var id: UUID = .init()
    var content: String
    var isUser: Bool
    var image: UIImage?
    var showoptions: Bool
}
