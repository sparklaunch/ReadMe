//
//  AddModalView.swift
//  ReadMe (iOS)
//
//  Created by Jinwook Kim on 2022/04/29.
//

import SwiftUI

struct AddModalView: View {
    @ObservedObject var book: Book = Book(title: .init(), author: .init(), microReview: .init(), readMe: .init())
    @State private var showingImagePicker: Bool = false
    @State private var selectedImage: UIImage?
    @State private var image: Image?
    var body: some View {
        Form {
            Section("Title and Author") {
                TextField("Type the title", text: $book.title)
                TextField("Type the author", text: $book.author)
            }
            Section("Image") {
                MicroReviewAndImagePickerView(book: book, image: $image)
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
