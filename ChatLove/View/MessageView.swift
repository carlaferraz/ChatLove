//
//  MessageView.swift
//  chatlove
//
//  Created by Carla Araujo on 02/08/25.
//

import SwiftUI

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
