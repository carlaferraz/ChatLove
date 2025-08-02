import SwiftUI

struct MessageView: View {
    var message: Message

    var body: some View {
        HStack {
            // Se a mensagem é do usuário, empurra para a direita
            if message.isUser {
                Spacer()
            }

            // Bloco de conteúdo (imagem ou texto)
            VStack(alignment: .leading) {
                // 1. Verifica se há uma IMAGEM na mensagem
                if let image = message.image {
                    Image(uiImage: image) // A sintaxe correta é aplicar os modificadores diretamente
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 250) // Usar maxWidth para ser mais flexível
                        .cornerRadius(15)
                        .padding(5)
                        .background(message.isUser ? Color("textFieldBox") : Color.gray.opacity(0.2))
                        .cornerRadius(20)

                // 2. Se não houver imagem, mostra o TEXTO
                } else {
                    if message.isUser {
                        // TEXTO DO USUÁRIO
                        Text(message.content)
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                            .foregroundStyle(.primary) // Adapta-se ao modo claro/escuro
                            .padding(.horizontal, 20)
                            .padding(.vertical, 16)
                            .background(Color("textFieldBox"))
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
                            .foregroundStyle(.secondary)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(20)
                    }
                }
            }

            // Se a mensagem é do bot, empurra para a esquerda
            if !message.isUser {
                Spacer()
            }
        }
    }
}
