//
//  Library.swift
//  ReadMe (iOS)
//
//  Created by Jinwook Kim on 2022/04/27.
//

import SwiftUI

enum Section: CaseIterable {
    case readMe
    case finished
}

class Library: ObservableObject {
    var sortedBooks: [Section : [Book]] {
        let groupedBooks = Dictionary(grouping: booksCache, by: \.readMe)
        return Dictionary(uniqueKeysWithValues: groupedBooks.map {
            (($0.key ? .readMe : .finished), $0.value)
        })
    }
    func sortBooks() {
        booksCache = sortedBooks
            .sorted { $1.key == .finished }
            .flatMap { $0.value }
        objectWillChange.send()
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
