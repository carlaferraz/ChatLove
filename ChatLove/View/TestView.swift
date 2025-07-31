//
//  TestView.swift
//  chatlove
//
//  Created by Carla Araujo on 30/07/25.
//

import SwiftUI

struct TestView: View {
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var storyManager: StoryManager
    
    let notify = NotificationHandler()
    
    @State var currentNodeID = "inicio"
    
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
            
            //body
            VStack(spacing: 35){
                //user
                HStack{
                    Spacer()
                    Text("Oi")
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                        .background(.textFieldBox)
                        .cornerRadius(30)
                }
                //bot
                HStack{
                    VStack(alignment: .leading, spacing: 21){
                        Text("Oii, Carla! Tudo bem? Como posso te\najudar hoje?")
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
                Spacer()
            }
            
            //textfield
            HStack{
                Image(systemName: "plus")
                    .foregroundStyle(.infos)
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                    .padding(18)
                    .background(.textFieldBox)
                    .cornerRadius(30)
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                HStack{
                    Text("Pergunte o que quiser")
                        .foregroundStyle(.text)
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                    Spacer()
                    Image(systemName: "microphone")
                        .foregroundStyle(.text)
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                    Spacer()
                    ZStack{
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
                .padding(.leading, 20)
                .padding(.trailing, 8)
                .background(.textFieldBox)
                .cornerRadius(30)
            }
            
        }
        .padding(20)
        .preferredColorScheme(.dark)
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

#Preview {
    TestView()
        .environmentObject(StoryManager())
}
