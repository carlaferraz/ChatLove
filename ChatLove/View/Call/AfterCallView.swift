//
//  AfterCallView.swift
//  chatlove
//
//  Created by Carla Araujo on 02/08/25.
//

import SwiftUI

struct AfterCallView: View {
    @State private var showText = false
    @State private var showButton = false
    
    var delay: CGFloat = 60
    let text: String = "Você não pode simplesmente me desligar."
    @State private var animatedText: String = ""

    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                if showText {
                    Text(animatedText)
                        .foregroundColor(.green)
                        .font(.system(.caption, design: .monospaced))
                        .font(.title2)
                        .transition(.opacity)
                        .animation(.easeIn(duration: 2), value: showText)
                        .task{
                            await animate()
                        }
                }
                if showButton {
                    
                    NavigationLink(destination: TerminalView()){
                        Text("Voltar a falar")
                            .foregroundColor(.green)
                            .font(.system(.caption, design: .monospaced))
                            .padding()
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(10)
                    }
                    .transition(.opacity)
                    .animation(.easeIn(duration: 2), value: showButton)
                    
                }
            }
        }.navigationBarBackButtonHidden(true)
        .onAppear {
            SoundManager.instance.playSound(sound: .glitch)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                showText = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                showButton = true
            }
        }
    }
    
    private func animate() async {
        for char in text {
            animatedText.append(char)
            try! await Task.sleep(for: .milliseconds(delay))
        }
    }
}
