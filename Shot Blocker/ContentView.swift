import SwiftUI
import Foundation

struct BlocklistEntry: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var label: String
    var pattern: String
    var isRegex: Bool = false
    var createdAt: Date = Date()
}

class BlocklistStore {
    // IMPORTANT: Update this App Group identifier to match your Xcode project settings for both the app and extension.
    static let appGroup = "group.com.yourcompany.ShotBlocker" // <-- Set your App Group here
    static let blocklistKey = "blocklist_entries"
    
    static func saveBlocklist(_ entries: [BlocklistEntry]) {
        if let data = try? JSONEncoder().encode(entries) {
            UserDefaults(suiteName: appGroup)?.set(data, forKey: blocklistKey)
        }
    }
    
    static func loadBlocklist() -> [BlocklistEntry] {
        guard let data = UserDefaults(suiteName: appGroup)?.data(forKey: blocklistKey),
              let entries = try? JSONDecoder().decode([BlocklistEntry].self, from: data) else {
            return []
        }
        return entries
    }
}

struct ContentView: View {
    @State private var entries: [BlocklistEntry] = BlocklistStore.loadBlocklist()
    @State private var newLabel: String = ""
    @State private var newPattern: String = ""
    @State private var useRegex: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Add to Blocklist")) {
                    TextField("Label (e.g., 'Spam 773 area code')", text: $newLabel)
                    TextField("Pattern (e.g., 773 or ^773)", text: $newPattern)
                    Toggle("Use Regular Expression", isOn: $useRegex)
                    Button("Add") { addEntry() }
                        .disabled(newPattern.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                
                Section(header: Text("Entries")) {
                    if entries.isEmpty {
                        Text("No entries yet.")
                    }
                    ForEach(entries) { entry in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(entry.label.isEmpty ? entry.pattern : entry.label)
                                    .font(.headline)
                                Text(entry.pattern)
                                    .font(.caption)
                            }
                            Spacer()
                            if entry.isRegex {
                                Text("Regex")
                                    .font(.caption)
                            }
                        }
                    }
                    .onDelete(perform: delete)
                }
            }
            .navigationTitle("Shot Blocker")
            .toolbar { EditButton() }
        }
        .onChange(of: entries) { BlocklistStore.saveBlocklist(entries) }
    }
    
    private func addEntry() {
        let trimmed = newPattern.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        let entry = BlocklistEntry(label: newLabel, pattern: trimmed, isRegex: useRegex)
        entries.append(entry)
        newLabel = ""
        newPattern = ""
        useRegex = false
    }
    
    private func delete(at offsets: IndexSet) {
        entries.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
 
