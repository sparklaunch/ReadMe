//
//  ContentView.swift
//  Shared
//
//  Created by Jinwook Kim on 2022/04/27.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var library: Library
    @State private var showingAddModal = false
    var body: some View {
        NavigationView {
            List {
                Button {
                    showingAddModal = true
                } label: {
                    VStack(spacing: 6) {
                        Image(systemName: "book.circle")
                            .font(.system(size: 60))
                        Text("Add new book…")
                            .font(.title2)
                    }
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.borderless)
                .padding(.vertical, 8)
                ForEach(library.sortedBooks) { book in
                    BookRowView(book: book)
                }
            }
            .sheet(isPresented: $showingAddModal) { AddModalView()
            }
            .navigationTitle("My Library")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewedInAllColorSchemes
            .environmentObject(Library())
    }
}
