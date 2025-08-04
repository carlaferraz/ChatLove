//
//  CameraView.swift
//  chatlove
//
//  Created by Carla Araujo on 02/08/25.
//

import SwiftUI
import PhotosUI

struct PhotoView: View {
    @State var selectedItem: PhotosPickerItem? //seleciona a foto
    @State var selectedImage: UIImage? //bota a foto
    @State var showingCamera = false //controla a camera
    
    var body: some View {
        VStack {
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
            } else {
                Text("No image selected")
                    .foregroundStyle(.red)
            }
            
            Button(action: {
                showingCamera = true // abre a camera
            }) {
                Text("Take photo")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.purple)
                    .foregroundStyle(.white)
            }
            .cornerRadius(12)
            .sheet(isPresented: $showingCamera){
                CameraView(image: $selectedImage)
            }
            
            PhotosPicker(
                selection: $selectedItem,
                matching: .images,//so imagens, sem videos
                photoLibrary: .shared()
            ) {
                Text("Select Photo")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundStyle(.white)
            }
            .cornerRadius(12)
            //aparece a imagem carregada na tela
            .onChange(of: selectedItem) {
                Task {
                    if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                        self.selectedImage = UIImage(data: data)
                    }
                }
            }
        }
        .padding()
    }
}

#Preview{
    PhotoView()
}
