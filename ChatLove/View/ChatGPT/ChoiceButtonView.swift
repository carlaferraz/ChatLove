//
//  ChoiceButtonView.swift
//  chatlove
//
//  Created by Carla Araujo on 02/08/25.
//

import SwiftUI

struct ChoiceButtonView: View {
    let choice: Choice
    let storyNode: StoryNode
    
    @ObservedObject var storyManager: StoryManager
    @ObservedObject var chatController: ChatController
    
    @Binding var shouldGoToTerminalView: Bool
    @Binding var shouldGoToCallView: Bool
    @Binding var showingCamera: Bool
    
    var body: some View {
        HStack {
            // ESCOLHAS DO USER
            Text(choice.textUser)
                .foregroundStyle(.white)
                .font(.system(size: 16))
                .fontWeight(.medium)
            
            Spacer()
            
            Button {
//                if choice.destination == .nodeRomance3 || choice.destination == .nodeSombria3 {
//                    shouldGoToTerminalView = true
//                    return
//                }
                if choice.destination == .nodeRomance2 {
                    shouldGoToCallView = true
                    return
                }
                
                if choice.destination == .nodeSombria2 {
                    shouldGoToTerminalView = true
                    return
                }
                
                if choice.destination == .nodeChat {
                    storyManager.tradedMessages = -99 // gambiarra kkkka
                    storyManager.currentGameState = .free
                    return
                }
                
                if choice.destination == .nodeCamera{
                    showingCamera = true
                    return
                }
                
                chatController.messages.append(
                    .init(content: storyNode.textBot, isUser: false)
                )
                
                chatController.messages.append(
                    .init(content: choice.textUser, isUser: true)
                )
                
                chatController.messages.append(
                    .init(content: choice.textBotReply, isUser: false)
                )
                
                storyManager.increaseTradedMessages(choice: choice)
                
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
