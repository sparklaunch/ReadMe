//
//  Library.swift
//  ReadMe (iOS)
//
//  Created by Jinwook Kim on 2022/04/27.
//

import Foundation

struct Library {
    var sortedBooks: [Book] {
        booksCache
    }
    private var booksCache: [Book] = [
        .init(title: "Memorandum", author: "Jinwook Kim"),
        .init(title: "Biography", author: "Jinwook Kim"),
        .init(title: "Anthropology", author: "Jinwook Kim"),
        .init(title: "Psychiatry", author: "Jinwook Kim"),
        .init(title: "Biodiversity", author: "Jinwook Kim")
    ]
}
