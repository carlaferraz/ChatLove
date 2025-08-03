//
//  ContentView.swift
//  chatlove
//
//  Created by Carla Araujo on 30/07/25.
//

import SwiftUI
import OpenAI
import PhotosUI

struct ContentView: View{
    
    @EnvironmentObject var storyManager: StoryManager
    
    @StateObject var chatController: ChatController = .init()
    
    @State var string: String = ""
    
    @State var isFocused: Bool
    
    @Environment(\.scenePhase) var scenePhase
    @State var selectedDate = Date()
    
    @State private var shouldGoToTerminalView = false
    @State private var shouldGoToCallView = false
    
    @State private var showingCamera = false //controla a camera
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    
    
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
            
            ChatHeaderView()
            Spacer()
            
            
            VStack(spacing: 35){
                MessageListView(chatController: chatController)
            }
            
            switch storyManager.currentGameState {
                //OPCOES PRA ENCAMINHAR A HISTORIA AGUI
            case .choice(let storyNode):
                // adicionar botoes pra escolhas
                VStack {
                    ForEach(storyNode.choices) { choice in
                        ChoiceButtonView(
                            choice: choice,
                            storyNode: storyNode,
                            storyManager: storyManager,
                            chatController: chatController,
                            shouldGoToTerminalView: $shouldGoToTerminalView,
                            shouldGoToCallView: $shouldGoToCallView,
                            showingCamera: $showingCamera
                        )
                        .padding(.vertical, 6)
                        .padding(.leading, 24)
                        .padding(.trailing, 10)
                        .background(.textFieldBox)
                        .cornerRadius(30)
                        
                    }
                }
                //USO LIVRE DO CHAT DOIDO AGUI
            case .free:
                // INPUT DIFERENCIADO
                if isFocused {
                    focusedInput
                } else {
                    unfocusedInput
                }
            }
        }
        .ignoresSafeArea(.all)
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
                    body: "Você não respondeu... eu não gostei disso.")
                HapticManager.instance.notification(type: .warning)
            }
            if newPhase == .active {
                print("App ficou ativo")
            }
        }
        .navigationDestination(
            isPresented: $shouldGoToTerminalView,
            destination: { TerminalView() }
        )
        .navigationDestination(
            isPresented: $shouldGoToCallView,
            destination: { CallView() }
        )
        
        .sheet(isPresented: $showingCamera){
            CameraView(image: $selectedImage)
        }
//        
        .onChange(of: selectedImage) { _, newImage in
            if let newImage = newImage{
                chatController.sendImageMessage(image: newImage)
                
                storyManager.advanceStoryAfterPhoto(chatController: chatController)
                
                selectedImage = nil
                selectedItem = nil
            }
        }
    }
}


