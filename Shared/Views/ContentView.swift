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
                ForEach(Section.allCases, id: \.self) {
                    SectionView(section: $0)
                }
            }
            .sheet(isPresented: $showingAddModal) { AddModalView()
            }
            .navigationTitle("My Library")
            .toolbar(content: EditButton.init)
        }
    }
}

private struct SectionView: View {
    let section: Section
    var title: String {
        switch section {
        case .readMe:
            return "Read Me!"
        case .finished:
            return "Finished!"
        }
    }
    @EnvironmentObject var library: Library
    var body: some View {
        if let books = library.sortedBooks[section] {
            SwiftUI.Section {
                ForEach(books) { book in
                    BookRowView(book: book)
                        .swipeActions(edge: .leading) {
                            Button {
                                withAnimation {
                                    book.readMe.toggle()
                                    library.sortBooks()
                                }
                            } label: {
                                book.readMe
                                ? Label("Finished", systemImage: "bookmark.slash")
                                : Label("Read Me!", systemImage: "bookmark")
                            }
                            .tint(.accentColor)
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                guard let index = books.firstIndex(where: { $0.id == book.id }) else {
                                    return
                                }
                                withAnimation {
                                    library.deleteBooks(at: .init(integer: index), section: section)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
                .onDelete { indexSet in
                    library.deleteBooks(at: indexSet, section: section)
                }
                .onMove { indices, newOffset in
                    library.moveBooks(oldOffsets: indices, newOffset: newOffset, section: section)
                }
                .labelStyle(.iconOnly)
            } header: {
                ZStack {
                    Image(systemName: "book")
                        .resizable()
                        .scaledToFit()
                    Text(title)
                        .font(.custom("American Typewriter", size: 24))
                        .foregroundColor(.primary)
                }
                .listRowInsets(.init())
            }
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
