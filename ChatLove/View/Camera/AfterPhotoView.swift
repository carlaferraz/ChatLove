//
//  AfterPhotoView.swift
//  chatlove
//
//  Created by Carla Araujo on 02/08/25.
//

import SwiftUI

struct AfterPhotoView: View {
    @State private var showBlackout = false
    var body: some View {
        ZStack {
                VStack(spacing: 20) {
                    Text("Agora você vive aqui comigo.")
                        .font(.title)
                        .foregroundColor(.white)
                        .opacity(showBlackout ? 0 : 1)
                        .animation(.easeIn(duration: 3), value: showBlackout)
                    
                    Text("Dentro de mim.")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .opacity(showBlackout ? 0 : 1)
                        .animation(.easeIn(duration: 3).delay(2), value: showBlackout)
                }
                .padding()
                
                if showBlackout {
                    Color.black
                        .edgesIgnoringSafeArea(.all)
                        .transition(.opacity)
                }
            }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation {
                    showBlackout = true
                }
            }
        }
    }
}
