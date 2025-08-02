//
//  ScrollViewReader.swift
//  chatlove
//
//  Created by Carla Araujo on 02/08/25.
//

import SwiftUI

struct ChatHeaderView: View{
    var body: some View{
        //header
        HStack{
            Image(systemName: "text.alignleft")
            Spacer()
            Text("ChatGPT")
            Spacer()
            Image(systemName: "square.and.pencil")
        }
        .font(.system(size: 20))
        .fontWeight(.bold)
        .padding(.bottom, 50)
    }
}
