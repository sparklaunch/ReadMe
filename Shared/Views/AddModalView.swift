//
//  AddModalView.swift
//  ReadMe (iOS)
//
//  Created by Jinwook Kim on 2022/04/29.
//

import SwiftUI

struct AddModalView: View {
    @State private var title: String = .init()
    @State private var author: String = .init()
    @State private var microReview: String = .init()
    @State private var showingImagePicker: Bool = false
    @State private var selectedImage: UIImage?
    @State private var image: Image?
    var body: some View {
        Form {
            Section("Title and Author") {
                TextField("Type the title", text: $title)
                TextField("Type the author", text: $author)
            }
            Section("Micro Review") {
                TextField("Type the micro review", text: $microReview)
            }
            Section("Image") {
                VStack(spacing: 16) {
                    Book.Image(title: title, image: image, cornerRadius: 16)
                        .scaledToFit()
                    HStack {
                        Button(image != nil ? "Change image…" : "Upload image…") {
                            showingImagePicker = true
                        }
                        .buttonStyle(.borderless)
                        if image != nil {
                            Spacer()
                            Button("Delete image…", role: .destructive) {
                                image = nil
                            }
                            .buttonStyle(.borderless)
                        }
                    }
                }
                .padding()
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $selectedImage)
        }
    }
    func loadImage() {
        guard let selectedImage = selectedImage else {
            return
        }
        image = Image(uiImage: selectedImage)
    }
}

struct AddModalView_Previews: PreviewProvider {
    static var previews: some View {
        AddModalView()
    }
}
