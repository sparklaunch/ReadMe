//
//  BookViews.swift
//  ReadMe (iOS)
//
//  Created by Jinwook Kim on 2022/04/27.
//

import SwiftUI

extension Book {
    struct Image: View {
        var body: some View {
            SwiftUI.Image(systemName: "book")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .font(.title.weight(.light))
                .foregroundColor(.secondary.opacity(0.5))
        }
    }
}

struct Book_Previews: PreviewProvider {
    static var previews: some View {
        Book.Image()
    }
}
