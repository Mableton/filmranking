import SwiftData
import Foundation // Für UUID und Date

@Model
class MediaItem {
    // Eindeutige ID
    @Attribute var id: UUID

    // Gemeinsame Attribute
    var title: String
    var type: MediaType // Film oder Serie
    var rating: Int // Bewertung (1–5 Sterne)
    var genre: String
    var comment: String?
    var timestamp: Date

    // Initialisierer
    init(title: String, type: MediaType, rating: Int, genre: String, comment: String? = nil) {
        self.id = UUID()
        self.title = title
        self.type = type
        self.rating = rating
        self.genre = genre
        self.comment = comment
        self.timestamp = Date()
    }
}

// Enum für Medientyp
enum MediaType: String, Codable {
    case film = "Film"
    case series = "Serie"
}
