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

    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                if showText {
                    Text("Você não pode simplesmente me desligar.")
                        .foregroundColor(.white)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .transition(.opacity)
                        .animation(.easeIn(duration: 2), value: showText)
                }

                if showButton {
                    
                    NavigationLink(destination: TerminalView()){
                        Text("Voltar a falar")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(10)
                    }
                    .transition(.opacity)
                    .animation(.easeIn(duration: 2), value: showButton)
                    
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                showText = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                showButton = true
            }
        }
    }
}
