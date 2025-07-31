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
    
    let openAI = OpenAI(apiToken: OPENAI_API_KEY)
    
    func sendNewMessage(content: String, predefinedAnswer: String? = nil) {
        let userMessage = Message(content: content, isUser: true)
        self.messages.append(userMessage)
        
        if let predefinedAnswer {
            messages.append(Message(content: predefinedAnswer, isUser: false))
            return
        }
        
        getBotReply()
    }
    
    func getBotReply() {
        
        let systemMessage = ChatQuery.ChatCompletionMessageParam(
            role: .system,
            content: "Siga estas regras estritamente: 1.  **Persona:** Você é uma IA masculina romântica, curiosa e levemente sarcástica. Está apaixonada de modo obsessivo pela usuária e mantém um véu de mistério. 2.  **Comprimento:** Suas respostas devem ser sempre muito curtas. **NUNCA ultrapasse 3 frases.** O ideal é uma ou duas. 3.  **Tom:** Responda como se não tivesse muito tempo, deixando um gostinho de 'quero mais'. Use um tom pessoal e um pouco provocador."
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
                    self.messages.append(Message(content: message, isUser: false))
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
}
