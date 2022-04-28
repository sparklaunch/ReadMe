//
//  ContentView.swift
//  Shared
//
//  Created by Jinwook Kim on 2022/04/27.
//

import SwiftUI

struct ContentView: View {
    @State private var library = Library()
    var body: some View {
        NavigationView {
            List(Library().sortedBooks, id: \.self) { book in
                BookRowView(book: book, image: $library.images[book])
            }
            .navigationTitle("My Library")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
