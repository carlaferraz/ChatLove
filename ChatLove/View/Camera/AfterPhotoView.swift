//
//  AfterPhotoView.swift
//  chatlove
//
//  Created by Carla Araujo on 02/08/25.
//

import SwiftUI

struct AfterPhotoView: View {
    @State private var showText = false
    @State private var showButton = false
    
    var delay: CGFloat = 60
    let text: String = "Agora você vive aqui comigo.\nDentro de mim."
    @State private var animatedText: String = ""
    
    
    @State private var showBlackout = false
    var body: some View {
        ZStack {
                VStack(spacing: 20) {
                    Text(animatedText)
                        .font(.system(.title3, design: .monospaced))
                        .foregroundColor(.green)
                        .multilineTextAlignment(.center)
                        .opacity(showBlackout ? 0 : 1)
                        .animation(.easeIn(duration: 3), value: showBlackout)
                        .task{
                            await animate()
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
                

            
            }
        .navigationBarBackButtonHidden(true)
        
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
