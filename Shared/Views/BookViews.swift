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
        let image: SwiftUI.Image?
        let cornerRadius: Double
        var size: CGFloat?
        var body: some View {
            if let image = image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .cornerRadius(cornerRadius)
            } else {
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
}

extension Book.Image {
    /// A PREVIEW IMAGE.
    init(title: String) {
        self.init(title: title, image: nil, cornerRadius: .init())
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
    @ObservedObject var book: Book
    @Binding var image: Image?
    var body: some View {
        NavigationLink(destination: DetailView(image: $image, book: book)) {
            HStack {
                Book.Image(title: book.title, image: image, cornerRadius: 12, size: 80)
                VStack(alignment: .leading) {
                    TitleAndAuthorView(book: book, titleFont: .title2, authorFont: .title3)
                        .lineLimit(1)
                    if !book.microReview.isEmpty {
                        Text(book.microReview)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                }
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
        .previewedInAllColorSchemes
    }
}

struct BookRowView_Previews: PreviewProvider {
    static var previews: some View {
        BookRowView(book: .init(), image: .constant(Image(systemName: "book")))
            .padding()
            .previewLayout(.sizeThatFits)
            .previewedInAllColorSchemes
    }
}

extension View {
    var previewedInAllColorSchemes: some View {
        ForEach(ColorScheme.allCases, id: \.self, content: preferredColorScheme)
    }
}
