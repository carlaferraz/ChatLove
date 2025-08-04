//
//  HomeView.swift
//  chatlove
//
//  Created by Carla Araujo on 30/07/25.
//

import SwiftUI

struct HomeView: View {
    let notify = NotificationHandler()
    var body: some View {
        NavigationStack{
            VStack{
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
                
                Spacer()
                
                VStack(spacing: 50){
                    VStack(spacing: 8){
                        Text("Welcome to ChatGPT")
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                        Button {
                            notify.askPermission()
                                
                        } label: {
                            Text("Request permissions")
                                .font(.system(size: 14))
                                .foregroundColor(.secondary)
                        }
                    }
                    VStack(spacing: 8){
                        NavigationLink(destination: ContentView(isFocused: false)){
                            HStack{
                                //Spacer()
                                Text("Iniciar")
                                    .foregroundStyle(.black)
                                //Spacer()
                            }
                            .padding(.vertical, 12)
                            .padding(.horizontal, 20)
                            .background(.white)
                            .cornerRadius(30)
                        }
                        
                    }
                    
                    
                }
                Spacer()
            }
        }
        .padding(20)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    HomeView()
}
