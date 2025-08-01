//
//  TypingTextView.swift
//  chatlove
//
//  Created by Carla Araujo on 01/08/25.
//

import SwiftUI

struct TypingTextView: View {
    let fullText: String
    @State private var displayedText = ""
    @State private var charIndex = 0
    let typingSpeed = 0.05
    
    var body: some View {
        Text(displayedText)
            .font(.system(.body, design: .monospaced))
            .foregroundColor(.red)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color.black)
            .onAppear {
                displayedText = ""
                charIndex = 0
                Timer.scheduledTimer(withTimeInterval: typingSpeed, repeats: true) { timer in
                    if charIndex < fullText.count {
                        let index = fullText.index(fullText.startIndex, offsetBy: charIndex)
                        displayedText.append(fullText[index])
                        charIndex += 1
                    } else {
                        timer.invalidate()
                    }
                }
            }
    }
}
