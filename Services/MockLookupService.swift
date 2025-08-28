import Foundation

// To use a real lookup API, replace this class with a service that performs network requests and parses results.
// For example, inject a protocol-based service into your ViewModel for easy swapping.
class MockLookupService {
    func lookup(number: String) -> CallerInfo? {
        // Placeholder: returns mock info for demo
        if number == "+15551234567" {
            return CallerInfo(number: number, name: "Spam Caller", type: "Spam")
        }
        if number.hasPrefix("800") {
            return CallerInfo(number: number, name: "Toll Free", type: "Business")
        }
        return nil
    }
}
