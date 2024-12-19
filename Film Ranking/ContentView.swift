import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var mediaItems: [MediaItem]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(groupedMediaItems.keys.sorted(), id: \.self) { type in
                    Section(header: Text(type.rawValue)) {
                        ForEach(groupedMediaItems[type] ?? []) { item in
                            NavigationLink {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(item.title)
                                        .font(.headline)
                                    Text("Genre: \(item.genre)")
                                        .font(.subheadline)
                                    Text("Rating: \(item.rating)/5")
                                        .font(.subheadline)
                                    if let comment = item.comment {
                                        Text("Comment: \(comment)")
                                            .font(.body)
                                    }
                                    Text("Added on: \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                                        .font(.footnote)
                                        .foregroundColor(.secondary)
                                }
                                .padding()
                            } label: {
                                Text(item.title)
                            }
                        }
                        .onDelete { offsets in
                            deleteMediaItems(ofType: type, at: offsets)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addMediaItem) {
                        Label("Add Media", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select a media item")
        }
    }

    // Gruppierung nach Typ
    private var groupedMediaItems: [MediaType: [MediaItem]] {
        Dictionary(grouping: mediaItems, by: { $0.type })
    }

    private func addMediaItem() {
        withAnimation {
            let newMedia = MediaItem(title: "New Title", type: .film, rating: 3, genre: "Unknown", comment: "Add a comment")
            modelContext.insert(newMedia)
        }
    }

    private func deleteMediaItems(ofType type: MediaType, at offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                if let itemToDelete = groupedMediaItems[type]?[index] {
                    modelContext.delete(itemToDelete)
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: MediaItem.self, inMemory: true)
}
