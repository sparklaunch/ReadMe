//
//  Book.swift
//  ReadMe (iOS)
//
//  Created by Jinwook Kim on 2022/04/27.
//

import Foundation

struct Book {
    let title: String
    let author: String
    init(title: String = "Memorandum", author: String = "Jinwook Kim") {
        self.title = title
        self.author = author
    }
}
