import Foundation
import CallKit

class BlocklistViewModel: ObservableObject {
    @Published var entries: [BlocklistEntry] = []
    
    // Sample data
    init() {
        let stored = BlocklistStore.loadBlocklist()
        if stored.isEmpty {
            entries = [
                BlocklistEntry(pattern: "^800[0-9]{7}$", isRegex: true, description: "Block all 800 numbers"),
                BlocklistEntry(pattern: "+15551234567", isRegex: false, description: "Block specific number")
            ]
        } else {
            entries = stored
        }
    }
    
    func addEntry(_ entry: BlocklistEntry) {
        entries.append(entry)
        save()
    }
    
    func removeEntry(_ entry: BlocklistEntry) {
        entries.removeAll { $0.id == entry.id }
        save()
    }
    
    func updateEntry(_ entry: BlocklistEntry) {
        if let idx = entries.firstIndex(where: { $0.id == entry.id }) {
            entries[idx] = entry
            save()
        }
    }
    
    func save() {
        BlocklistStore.saveBlocklist(entries)
        // IMPORTANT: The identifier below must match your Call Directory Extension's bundle identifier in Xcode.
        let manager = CXCallDirectoryManager.shared
        manager.reloadExtension(withIdentifier: "com.yourcompany.Shot-Blocker.CallDirectoryExtension") { error in
            if let error = error {
                print("Failed to reload extension: \(error)")
            } else {
                print("Call Directory Extension reloaded.")
            }
        }
    }
}
