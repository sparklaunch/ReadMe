//
//  Library.swift
//  ReadMe (iOS)
//
//  Created by Jinwook Kim on 2022/04/27.
//

import SwiftUI

class Library: ObservableObject {
    var sortedBooks: [Book] {
        booksCache
    }
    /// Adds a new book.
    func addNewBook(_ book: Book, image: Image?) {
        booksCache.insert(book, at: .zero)
        images[book] = image ?? .init(systemName: "book")
    }
    @Published var booksCache: [Book] = [
        .init(title: "Memorandum", author: "Jinwook Kim"),
        .init(title: "Biography", author: "Jinwook Kim"),
        .init(title: "Anthropology", author: "Jinwook Kim"),
        .init(title: "Psychiatry", author: "Jinwook Kim"),
        .init(title: "Biodiversity", author: "Jinwook Kim")
    ]
    @Published var images: [Book: Image] = [:]
}
