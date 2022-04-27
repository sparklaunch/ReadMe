//
//  ContentView.swift
//  Shared
//
//  Created by Jinwook Kim on 2022/04/27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Group {
            BookRowView(book: Book(title: "Memorandum", author: "Jinwook Kim"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
