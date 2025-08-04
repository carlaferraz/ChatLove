//
//  CallView.swift
//  chatlove
//
//  Created by Carla Araujo on 31/07/25.
//

import SwiftUI
import AVKit


struct CallView: View {
    
    var body: some View {
        NavigationStack{
            ZStack{
                Image("backgroundCall")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(edges: .all)
                
                
                
                VStack(spacing: 16){
                    HStack{
                        Spacer()
                        Image(systemName: "info.circle")
                            .foregroundStyle(.text)
                            .font(.system(size: 20))
                    }
                    
                    VStack(spacing: 8){
                        Text("Unknow, ??")
                            .foregroundStyle(.text)
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                        Text("+1 (333) 612-****")
                            .foregroundStyle(.white)
                            .font(.system(size: 32))
                            .fontWeight(.bold)
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 30){
                        HStack{
                            VStack(spacing: 8){
                                VStack{
                                    Image(systemName: "message.fill")
                                }
                                .frame(width: 44, height: 44)
                                .background(.text)
                                .opacity(0.6)
                                .cornerRadius(100)
                                Text("Message")
                                    .foregroundStyle(.text)
                                    .font(.system(size: 14))
                            }
                            Spacer()
                            VStack(spacing: 8){
                                VStack{
                                    Image(systemName: "recordingtape")
                                }
                                .frame(width: 44, height: 44)
                                .background(.text)
                                .opacity(0.6)
                                .cornerRadius(100)
                                Text("Voicemail")
                                    .foregroundStyle(.text)
                                    .font(.system(size: 14))
                            }
                        }
                        .padding(.horizontal, 8)
                        
                       
                            HStack{
                                VStack(spacing: 8){
                                    NavigationLink(destination: AfterCallView()){
                                        VStack{
                                            Image(systemName: "phone.down.fill")
                                                .font(.system(size: 28))
                                                .foregroundStyle(.white)
                                        }
                                        .frame(width: 76, height: 76)
                                        .background(.red)
                                        .cornerRadius(100)
                                    }.transition(.opacity)
                                    Text("Decline")
                                        .foregroundStyle(.text)
                                        .font(.system(size: 14))
                                }
                                Spacer()
                                VStack(spacing: 8){
                                    NavigationLink(destination: CallViewAccepted()){
                                        VStack{
                                            Image(systemName: "phone.fill")
                                                .font(.system(size: 28))
                                                .foregroundStyle(.white)
                                        }
                                        .frame(width: 76, height: 76)
                                        .background(.green)
                                        .cornerRadius(100)
                                    }
                                    
                                    Text("Accept")
                                        .foregroundStyle(.text)
                                        .font(.system(size: 14))
                                }
                            }
                    }
                    .padding(30)
                }
                .navigationBarBackButtonHidden(true)
                .padding(.horizontal, 12)
                .padding(.vertical, 74)
                .onAppear {
                    SoundManager.instance.playSound(sound: .calling)
                    HapticManager.instance.impact(style: .heavy)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    CallView()
}
