import Foundation

// To use a real reporting API, replace this class with a service that performs network requests to send reports.
// Use a protocol for easy swapping in your ViewModel.
class MockReportService {
    func sendReport(_ entry: ReportEntry) {
        // Placeholder: send to server (not implemented)
    }
}
