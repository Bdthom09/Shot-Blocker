// Models for phone numbers, blocklist entries, reports, and caller info
import Foundation

struct BlocklistEntry: Identifiable, Codable, Equatable {
    let id: UUID
    var pattern: String // Regex or exact number
    var isRegex: Bool
    var description: String?
    
    init(pattern: String, isRegex: Bool = false, description: String? = nil) {
        self.id = UUID()
        self.pattern = pattern
        self.isRegex = isRegex
        self.description = description
    }
}

struct CallerInfo: Identifiable, Codable, Equatable {
    let id: UUID = UUID()
    let number: String
    let name: String?
    let type: String? // e.g. spam, business, etc.
}

struct ReportEntry: Identifiable, Codable, Equatable {
    let id: UUID = UUID()
    let number: String
    let date: Date
    let reason: String?
}
