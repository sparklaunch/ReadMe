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
                }
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
