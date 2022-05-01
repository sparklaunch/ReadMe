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
    @EnvironmentObject var library: Library
    @ObservedObject var book: Book
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 16) {
                Button {
                    book.readMe.toggle()
                } label: {
                    Image(systemName: book.readMe ? "bookmark.fill" : "bookmark")
                        .font(.system(size: 48, weight: .light))
                }
                TitleAndAuthorView(book: book, titleFont: .largeTitle, authorFont: .title3)
            }
            MicroReviewAndImagePickerView(book: book, image: $library.images[book])
            Spacer()
        }
        .padding()
        .onDisappear {
            withAnimation {
                library.sortBooks()
            }
        }
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
        DetailView(book: .init())
            .environmentObject(Library())
    }
}
