//
//  DetailView.swift
//  ReadMe (iOS)
//
//  Created by Jinwook Kim on 2022/04/27.
//

import SwiftUI

struct DetailView: View {
    @State private var showingImagePicker = false
    @State private var showingConfirmationDialog = false
    @State private var selectedImage: UIImage?
    @Binding var image: Image?
    let book: Book
    var body: some View {
        VStack(alignment: .leading) {
            TitleAndAuthorView(book: book, titleFont: .largeTitle, authorFont: .title3)
            VStack {
                Book.Image(title: book.title, image: image, cornerRadius: 16)
                    .scaledToFit()
                HStack {
                    Button("Update Image…") {
                        showingImagePicker = true
                    }
                    .padding()
                    if image != nil {
                        Button("Delete Image…") {
                            showingConfirmationDialog = true
                        }
                        .padding()
                    }
                }
            }
            Spacer()
        }
        .padding()
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $selectedImage)
        }
        .confirmationDialog("Delete image for \(book.title)?", isPresented: $showingConfirmationDialog) {
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

struct TitleAndAuthorView: View {
    let book: Book
    let titleFont: Font
    let authorFont: Font
    var body: some View {
        VStack(alignment: .leading) {
            Text(book.title)
                .font(titleFont)
                .fontWeight(.semibold)
            Text(book.author)
                .font(authorFont)
                .foregroundColor(.secondary)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(image: .constant(Image(systemName: "book")), book: .init())
    }
}
