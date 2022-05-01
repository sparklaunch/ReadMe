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
    @EnvironmentObject var library: Library
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            Form {
                SwiftUI.Section("Title and Author") {
                    TextField("Type the title", text: $book.title)
                    TextField("Type the author", text: $book.author)
                }
                SwiftUI.Section("Image") {
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
                        dismiss()
                    }
                    .disabled(
                        [book.title, book.author].contains(where: \.isEmpty))
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
        AddModalView()
            .environmentObject(Library())
    }
}
