//
//  DetailView.swift
//  ReadMe (iOS)
//
//  Created by Jinwook Kim on 2022/04/27.
//

import SwiftUI

struct DetailView: View {
    let book: Book
    var body: some View {
        VStack(alignment: .leading) {
            TitleAndAuthorView(book: book, titleFont: .largeTitle, authorFont: .title3)
            Book.Image(title: book.title)
            Spacer()
        }
        .padding() 
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
    }
}
