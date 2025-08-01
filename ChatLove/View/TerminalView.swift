//
//  TerminalView.swift
//  chatlove
//
//  Created by Carla Araujo on 31/07/25.
//

import SwiftUI
import OpenAI

struct TerminalView: View {
    
    @StateObject var chatController: ChatController = .init()
    
    @State var string: String = ""
 
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView{
                Text("IA: Bem-vindo ao terminal privado. Explore meus pensamentos com [help] ou conte-me sobre os seus.")
                ForEach(chatController.messages) { message in
                    MessageTerminalView(messageTerminal: message)
                }
            }
            HStack{
                TextField("Fale comigo, amor...", text: $string)
                    .font(.system(.body, design: .monospaced))
                Button{
                    chatController.sendNewMessage(content: string)
                    string = ""
                } label: {
                    Text(">")
                        .font(.system(.body, design: .monospaced))
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 40)
        .background(Color.black)
        .foregroundColor(.green)
        .font(.system(.caption, design: .monospaced))
    }
}

struct MessageTerminalView: View{
    var messageTerminal: Message
    var body: some View{
        Group{
            if messageTerminal.isUser{
                HStack{
                    Text(">")
                    Text(messageTerminal.content)
                }
            } else {
                VStack(alignment: .leading){
                    Text(messageTerminal.content)
                }
                
            }
        }
    }
}


//#Preview{
//    TerminalView()
//}
