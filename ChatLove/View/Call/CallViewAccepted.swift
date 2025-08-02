//
//  CallViewAccepted.swift
//  chatlove
//
//  Created by Carla Araujo on 31/07/25.
//

import SwiftUI

struct CallViewAccepted: View {
    
    @State private var timeRemaining = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var formattedTime: String{
        let minutes = timeRemaining/60
        let seconds = timeRemaining%60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    var body: some View {
        ZStack{
            Image("backgroundCall")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(edges: .all)
            
            
            
            VStack(spacing: 16){
                Spacer()
                VStack(spacing: 8){
                    Text("Unknow, ??")
                        .foregroundStyle(.white)
                        .font(.system(size: 32))
                        .fontWeight(.bold)
                    Text("\(formattedTime)")
                        .onReceive(timer) { input in
                            
                            timeRemaining += 1
                            
                        }
                        .foregroundStyle(.text)
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                }
                .padding(.bottom, 50)
                
                Spacer()
                
                VStack(spacing: 30){
                    HStack{
                        VStack(spacing: 8){
                            VStack{
                                Image(systemName: "microphone.slash.fill")
                                    .font(.system(size: 28))
                            }
                            .frame(width: 76, height: 76)
                            .background(.text)
                            .opacity(0.6)
                            .cornerRadius(100)
                            Text("mute")
                                .foregroundStyle(.white)
                                .font(.system(size: 14))
                        }
                        Spacer()
                        VStack(spacing: 8){
                            VStack{
                                Image(systemName: "teletype")
                                    .font(.system(size: 28))
                            }
                            .frame(width: 76, height: 76)
                            .background(.text)
                            .opacity(0.6)
                            .cornerRadius(100)
                            Text("keypad")
                                .foregroundStyle(.white)
                                .font(.system(size: 14))
                        }
                        Spacer()
                        VStack(spacing: 8){
                            VStack{
                                Image(systemName: "speaker.wave.3.fill")
                                    .font(.system(size: 28))
                            }
                            .frame(width: 76, height: 76)
                            .background(.text)
                            .opacity(0.6)
                            .cornerRadius(100)
                            Text("speaker")
                                .foregroundStyle(.white)
                                .font(.system(size: 14))
                        }
                    }
                    .padding(.horizontal, 8)
                    
                    HStack{
                        VStack(spacing: 8){
                            VStack{
                                Image(systemName: "plus")
                                    .font(.system(size: 28))
                            }
                            .frame(width: 76, height: 76)
                            .background(.text)
                            .opacity(0.6)
                            .cornerRadius(100)
                            Text("add call")
                                .foregroundStyle(.white)
                                .font(.system(size: 14))
                        }
                        Spacer()
                        VStack(spacing: 8){
                            VStack{
                                Image(systemName: "video.fill")
                                    .font(.system(size: 28))
                            }
                            .frame(width: 76, height: 76)
                            .background(.text)
                            .opacity(0.6)
                            .cornerRadius(100)
                            Text("FaceTime")
                                .foregroundStyle(.white)
                                .font(.system(size: 14))
                        }
                        Spacer()
                        VStack(spacing: 8){
                            VStack{
                                Image(systemName: "person.crop.circle")
                                    .font(.system(size: 28))
                            }
                            .frame(width: 76, height: 76)
                            .background(.text)
                            .opacity(0.6)
                            .cornerRadius(100)
                            Text("contacts")
                                .foregroundStyle(.white)
                                .font(.system(size: 14))
                        }
                    }
                    .padding(.horizontal, 8)
                    
                    Spacer()
                    
                    VStack(spacing: 8){
                        VStack{
                            Image(systemName: "phone.down.fill")
                                .font(.system(size: 28))
                        }
                        .frame(width: 76, height: 76)
                        .background(.red)
                        .cornerRadius(100)
                    }

                }
                .padding(30)
                
                
                
                
                
            }
            .navigationBarBackButtonHidden(true)
            .padding(.horizontal, 12)
            .padding(.vertical, 74)
            .onAppear {
                SoundManager.instance.playSound(sound: .voice)
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    CallViewAccepted()
}
