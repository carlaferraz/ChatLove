import SwiftUI

struct MessageView: View {
    var message: Message

    var body: some View {
        HStack {
            if message.isUser {
                Spacer()
            }

            VStack(alignment: .leading) {
//                if let image = message.image {
//                    Image(uiImage: image)
//                        .resizable()
//                        .scaledToFit()
//                        .cornerRadius(15)
//                        .padding(5)
//                        .background(message.isUser ? Color("textFieldBox") : Color.gray.opacity(0.2))
//                        .cornerRadius(20)
//
//                } else {
                    if message.isUser {
                        // TEXTO DO USUÁRIO
                        Text(message.content)
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 16)
                            .background(.textFieldBox)
                            .cornerRadius(30)
                    } else {
                        // TEXTO DO BOT
                        VStack(alignment: .leading, spacing: 15) {
                            Text(message.content)
                                .font(.system(size: 19))

                            HStack(spacing: 15) {
                                Image(systemName: "document.on.document")
                                Image(systemName: "speaker.wave.2")
                                Image(systemName: "hand.thumbsup")
                                Image(systemName: "hand.thumbsdown")
                            }
                            .font(.system(size: 17))
                        }
                        .padding()
                    }
//                }
            }

            if !message.isUser {
                Spacer()
            }
        }
    }
}
