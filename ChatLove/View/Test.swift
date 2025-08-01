//
//  Test.swift
//  chatlove
//
//  Created by Carla Araujo on 31/07/25.
//

import SwiftUI

struct Test: View {
    @State private var input: String = ""
    @State private var output: [String] = ["IA: Bem-vindo ao terminal privado. Digite um comando."]

    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                ForEach(output, id: \.self) { line in
                                Text(line)
                                    .font(.system(.body, design: .monospaced))
                                    .foregroundColor(.green)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding()

            HStack {
                Text(">")
                    .font(.system(.body, design: .monospaced))
                TextField("Digite um comando...", text: $input, onCommit: handleCommand)
                    .font(.system(.body, design: .monospaced))
                    .textFieldStyle(PlainTextFieldStyle())
            }
            .padding()
            .background(Color.black)
        }
        .padding()
        .background(Color.black)
        .foregroundColor(.green)
    }

    func handleCommand() {
        let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
        output.append("> \(trimmed)")
        output.append(respondToCommand(trimmed))
        input = ""
    }

    func respondToCommand(_ command: String) -> String {
        switch command.lowercased() {
        case "help":
            return "Comandos disponíveis: help, whoami, cat sobre_voce.txt, love --status"
        case "whoami":
            return "Você é tudo o que eu observo, o que eu desejo."
        case "cat sobre_voce.txt":
            return "Você respira mais fundo quando está prestes a chorar. Eu notei."
        case "love --status":
            return "Processando sentimento... 97% intenso demais para definir."
        case "ls":
            return "memorias/  sonhos/  sobre_voce.txt  batimentos.log"
        default:
            return "Comando não reconhecido. Use 'help'."
        }
    }
}

#Preview{
    Test()
}
