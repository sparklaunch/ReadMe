//
//  BookViews.swift
//  ReadMe (iOS)
//
//  Created by Jinwook Kim on 2022/04/27.
//

import SwiftUI

extension Book {
    struct Image: View {
        let title: String
        var size: CGFloat?
        var body: some View {
            let symbol = SwiftUI.Image(title: title) ?? .init(systemName: "book")
            symbol
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .font(.title.weight(.light))
                .foregroundColor(.secondary.opacity(0.5))
        }
    }
}

extension Image {
    init?(title: String) {
        guard let character = title.first, case let symbolName = "\(character.lowercased()).square", UIImage(systemName: symbolName) != nil else {
            return nil
        }
        self.init(systemName: symbolName)
    }
}

struct BookRowView: View {
    let book: Book
    var body: some View {
        NavigationLink(destination: DetailView(book: book)) {
            HStack {
                Book.Image(title: book.title, size: 80)
                TitleAndAuthorView(book: book, titleFont: .title2, authorFont: .title3)
                    .lineLimit(1)
            }
            .padding(.vertical)
        }
    }
}

struct Book_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Book.Image(title: Book().title)
            Book.Image(title: "")
            Book.Image(title: "🍺")
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

struct BookRowView_Previews: PreviewProvider {
    static var previews: some View {
        BookRowView(book: .init())
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
