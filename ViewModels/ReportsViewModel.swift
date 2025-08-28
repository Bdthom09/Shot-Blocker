import Foundation
import CallKit

class BlocklistViewModel: ObservableObject {
    static let extensionIdentifier = "com.yourcompany.Shot-Blocker.CallDirectoryExtension" // <-- Update to match your Xcode extension bundle ID
    @Published var entries: [BlocklistEntry] = []
    
    // Sample data
    init() {
        entries = [
            BlocklistEntry(pattern: "^800[0-9]{7}$", isRegex: true, description: "Block all 800 numbers"),
            BlocklistEntry(pattern: "+15551234567", isRegex: false, description: "Block specific number")
        ]
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
        // Request Call Directory Extension reload
        let manager = CXCallDirectoryManager.shared
        manager.reloadExtension(withIdentifier: Self.extensionIdentifier) { error in
            if let error = error {
                print("Failed to reload extension: \(error)")
            } else {
                print("Call Directory Extension reloaded.")
            }
        }
    }
}
// App Group identifier and Call Directory Extension identifier must be updated to match your project settings.//

class ReportsViewModel: ObservableObject {
    static let appGroup = "group.com.yourcompany.ShotBlocker"
    static let reportsKey = "reports_entries"
    @Published var reports: [ReportEntry] = [] {
        didSet { save() }
    }
    let reportService = MockReportService()
    
    init() {
        self.reports = Self.loadReports()
    }
    
    func report(number: String, reason: String?) {
        let entry = ReportEntry(number: number, date: Date(), reason: reason)
        reports.append(entry)
        reportService.sendReport(entry)
    }
    
    func removeReport(_ entry: ReportEntry) {
        reports.removeAll { $0.id == entry.id }
    }
    
    private func save() {
        if let data = try? JSONEncoder().encode(reports) {
            UserDefaults(suiteName: Self.appGroup)?.set(data, forKey: Self.reportsKey)
        }
    }
    
    private static func loadReports() -> [ReportEntry] {
        guard let data = UserDefaults(suiteName: appGroup)?.data(forKey: reportsKey),
              let entries = try? JSONDecoder().decode([ReportEntry].self, from: data) else {
            return []
        }
        return entries
    }
}
