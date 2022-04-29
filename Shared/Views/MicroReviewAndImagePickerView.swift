//
//  MicroReviewAndImagePickerView.swift
//  ReadMe (iOS)
//
//  Created by Jinwook Kim on 2022/04/29.
//

import SwiftUI

struct MicroReviewAndImagePickerView: View {
    @ObservedObject var book: Book
    @Binding var image: Image?
    @State private var selectedImage: UIImage?
    @State private var showingImagePicker = false
    @State private var showingConfirmationDialogue = false
    var body: some View {
        VStack(spacing: 16) {
            TextField("Write your micro review…", text: $book.microReview)
            VStack(spacing: 16) {
                Book.Image(title: book.title, image: image, cornerRadius: 16)
                    .scaledToFit()
                HStack {
                    Button("Update Image…") {
                        showingImagePicker = true
                    }
                    .buttonStyle(.borderless)
                    .padding()
                    if image != nil {
                        Button("Delete Image…") {
                            showingConfirmationDialogue = true
                        }
                        .buttonStyle(.borderless)
                        .padding()
                    }
                }
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $selectedImage)
        }
        .confirmationDialog("Delete image for \(book.title)?", isPresented: $showingConfirmationDialogue) {
            Button("Delete", role: .destructive) {
                image = nil
            }
        } message: {
            Text("Delete image for \(book.title)?")
        }
    }
    func loadImage() {
        guard let selectedImage = selectedImage else {
            return
        }
        image = Image(uiImage: selectedImage)
    }
}

struct MicroReviewAndImagePickerView_Previews: PreviewProvider {
    static var previews: some View {
        MicroReviewAndImagePickerView(book: .init(), image: .constant(nil))
    }
}
