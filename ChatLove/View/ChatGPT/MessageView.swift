import SwiftUI

struct MessageView: View {
    var message: Message
    
    var delay: CGFloat = 40
    @State private var animatedText: String = ""
    
    var body: some View {
        HStack {
            if message.isUser {
                Spacer()
            }
            
            VStack(alignment: .leading) {
                if let image = message.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(15)
                        .padding(5)
                        .background(message.isUser ? Color("textFieldBox") : Color.gray.opacity(0.2))
                        .cornerRadius(20)
                    
                } else {
                    if message.isUser {
                        // TEXTO DO USUÁRIO
                        Text(message.content)
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 16)
                            .background(.textFieldBox)
                            .cornerRadius(30)
                            .padding(.vertical, 16)
                    } else {
                        // TEXTO DO BOT
                        VStack(alignment: .leading, spacing: 15) {
                            Text(animatedText.isEmpty ? message.content : animatedText)
                                .font(.system(size: 18))
                                .onAppear {
                                    if animatedText.isEmpty {
                                        Task {
                                            await animate(text: message.content)
                                        }
                                    }
                                }
                            
                            if message.showoptions {
                                HStack(spacing: 15) {
                                    Image(systemName: "document.on.document")
                                    Image(systemName: "speaker.wave.2")
                                    Image(systemName: "hand.thumbsup")
                                    Image(systemName: "hand.thumbsdown")
                                    Image(systemName: "square.and.arrow.up")
                                }
                                //.padding()
                                .font(.system(size: 17))
                            }
                            
                        }
                        
                    }
                }
            }
            
            if !message.isUser {
                Spacer()
            }
        }
    }
    
    private func animate(text: String) async {
        animatedText = ""
        for char in text {
            await MainActor.run {
                animatedText.append(char)
            }
            try? await Task.sleep(nanoseconds: UInt64(delay * 1_000_000))
        }
    }
    
}
