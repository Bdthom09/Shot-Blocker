import Foundation

class LookupViewModel: ObservableObject {
    @Published var searchNumber: String = ""
    @Published var result: CallerInfo?
    
    let lookupService = MockLookupService()
    
    func lookup() {
        result = lookupService.lookup(number: searchNumber)
    }
}
