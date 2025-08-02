//
//  MessageListView.swift
//  chatlove
//
//  Created by Carla Araujo on 02/08/25.
//

// MessageListView.swift
import SwiftUI

struct MessageListView: View {
    @ObservedObject var chatController: ChatController

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack {
                    ForEach(chatController.messages) { message in
                        MessageView(message: message)
                            .padding(.horizontal, 3)
                            .id(message.id)
                    }
                }
                .padding(.vertical)
            }
            .onChange(of: chatController.messages.count) { _, _ in
                if let lastMessageId = chatController.messages.last?.id {
                    withAnimation {
                        proxy.scrollTo(lastMessageId, anchor: .bottom)
                    }
                }
            }
        }
    }
}
