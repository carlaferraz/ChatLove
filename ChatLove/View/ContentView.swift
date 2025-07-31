//
//  ContentView.swift
//  chatlove
//
//  Created by Carla Araujo on 30/07/25.
//

import SwiftUI
import OpenAI

struct ContentView: View{
    
    @EnvironmentObject var storyManager: StoryManager
    
    @StateObject var chatController: ChatController = .init()
    
    @State var string: String = ""
    
    @State var isFocused: Bool
    
    @Environment(\.scenePhase) var scenePhase
    @State var selectedDate = Date()
    let notify = NotificationHandler()
    
    var focusedInput: some View {
        HStack {
            Image(systemName: "plus")
                .foregroundStyle(.infos)
                .font(.system(size: 18))
                .fontWeight(.medium)
                .padding(16)
                .background(.textFieldBox)
                .cornerRadius(30)
            
            HStack {
                TextField("Pergunte o que quiser", text: $string, axis: .vertical)
                    .foregroundStyle(.text)
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                Spacer()
                Button {
                    storyManager.increaseTradedMessages()
                    
                    switch storyManager.currentGameState {
                    case .choice(let storyNode):
                        chatController.sendNewMessage(
                            content: string,
                            predefinedAnswer: storyNode.textBot
                        )
                    case .free:
                        chatController.sendNewMessage(content: string)
                    }
                    
                    string = ""
                    isFocused = false
                } label: {
                    Image(systemName: "arrow.up")
                        .font(.system(size: 17))
                        .fontWeight(.bold)
                        .padding(10)
                        .foregroundStyle(.black)
                        .background(.white)
                        .cornerRadius(30)
                }
            }
            .padding(.vertical, 6)
            .padding(.leading, 24)
            .padding(.trailing, 10)
            .background(.textFieldBox)
            .cornerRadius(30)
        }
    }
    
    
    var unfocusedInput: some View {
        HStack {
            Image(systemName: "plus")
                .foregroundStyle(.infos)
                .font(.system(size: 18))
                .fontWeight(.medium)
                .padding(16)
                .background(.textFieldBox)
                .cornerRadius(30)
            
            HStack {
                Text("Pergunte o que...")
                    .foregroundStyle(.text)
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                Spacer()
                Image(systemName: "microphone")
                    .foregroundStyle(.text)
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                Spacer()
                ZStack {
                    Image(systemName: "waveform")
                        .font(.system(size: 17))
                        .fontWeight(.bold)
                        .padding(10)
                        .foregroundStyle(.black)
                        .background(.white)
                        .cornerRadius(30)
                }
            }
            .padding(.vertical, 6)
            .padding(.leading, 24)
            .padding(.trailing, 10)
            .background(.textFieldBox)
            .cornerRadius(30)
            .onTapGesture {
                isFocused.toggle()
            }
        }
    }
    
    
    var body: some View {
        VStack{
            
            //header
            HStack{
                Image(systemName: "text.alignleft")
                Spacer()
                Text("ChatGPT")
                Spacer()
                Image(systemName: "square.and.pencil")
            }
            .font(.system(size: 20))
            .fontWeight(.bold)
            .padding(.bottom, 50)
            Spacer()
            
            
            VStack(spacing: 35){
                ScrollView {
                    ForEach(chatController.messages) { message in
                        MessageView(message: message)
                            .padding(5)
                    }
                }
            }
            
            switch storyManager.currentGameState {
            case .choice(let storyNode):
                // adicionar botoes pra escolhas
                VStack {
                    ForEach(storyNode.choices) { choice in
                        HStack{
                            Text(choice.textUser)
                                .foregroundStyle(.white)
                                .font(.system(size: 16))
                                .fontWeight(.medium)
                            Spacer()
                            Button{
                                chatController.messages.append(.init(content: storyNode.choices[0].textUser, isUser: true))
                                storyManager.currentGameState = .free
                            } label: {
                                Image(systemName: "arrow.up")
                                    .font(.system(size: 17))
                                    .fontWeight(.bold)
                                    .padding(10)
                                    .foregroundStyle(.black)
                                    .background(.white)
                                    .cornerRadius(30)
                            }
                        }
                        .padding(.vertical, 6)
                        .padding(.leading, 24)
                        .padding(.trailing, 10)
                        .background(.textFieldBox)
                        .cornerRadius(30)
                        
                    }
                    
//                    if isFocused {
//                        focusedInput
//                    } else {
//                        unfocusedInput
//                    }
                }
            case .free:
                // INPUT DIFERENCIADO
                if isFocused {
                    focusedInput
                } else {
                    unfocusedInput
                }
            }
        }
        .padding(12)
        .navigationBarBackButtonHidden(true)
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .background {
                print("App entrou em segundo plano. Agendando notificação.")
                
                notify.sendNotification(
                    date: Date(),
                    type: "time",
                    timeInterval: 3,
                    title: "Eu sei onde você está.",
                    body: "Você não respondeu. Não gostei disso.")
            }
            if newPhase == .active {
                print("App ficou ativo")
            }
            
        }
    }
}


struct MessageView: View{
    var message: Message
    var body: some View {
        Group{
            if message.isUser{
                //user
                HStack{
                    Spacer()
                    Text(message.content)
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                        .background(.textFieldBox)
                        .cornerRadius(30)
                }
            } else {
                //bot
                HStack{
                    VStack(alignment: .leading, spacing: 21){
                        Text(message.content)
                            .font(.system(size: 19))
                        HStack(spacing: 10){
                            Image(systemName: "document.on.document")
                            Image(systemName: "speaker.wave.2")
                            Image(systemName: "hand.thumbsup")
                            Image(systemName: "hand.thumbsdown")
                            Image(systemName: "repeat")
                            Image(systemName: "square.and.arrow.up")
                        }
                        .font(.system(size: 17))
                    }
                    
                    Spacer()
                }
            }
        }
    }
}
