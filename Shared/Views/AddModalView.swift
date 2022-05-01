//
//  AddModalView.swift
//  ReadMe (iOS)
//
//  Created by Jinwook Kim on 2022/04/29.
//

import SwiftUI

struct AddModalView: View {
    @ObservedObject var book: Book = Book(title: "", author: "", microReview: "", readMe: true)
    @State private var showingImagePicker: Bool = false
    @State private var selectedImage: UIImage?
    @State private var image: Image?
    @Binding var showingAddModal: Bool
    @EnvironmentObject var library: Library
    var body: some View {
        NavigationView {
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
            .toolbar {
                ToolbarItem(placement: .status) {
                    Button("Add to library…") {
                        library.addNewBook(book, image: image)
                        showingAddModal = false
                    }
                }
            }
            .navigationTitle("Got a new book?")
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
        AddModalView(showingAddModal: .constant(true))
            .environmentObject(Library())
    }
}
