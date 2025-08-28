import Foundation

struct RegexBlocker {
    static func matches(number: String, patterns: [BlocklistEntry]) -> Bool {
        for entry in patterns {
            if entry.isRegex {
                if let regex = try? NSRegularExpression(pattern: entry.pattern) {
                    let range = NSRange(location: 0, length: number.utf16.count)
                    if regex.firstMatch(in: number, options: [], range: range) != nil {
                        return true
                    }
                }
            } else if entry.pattern == number {
                return true
            }
        }
        return false
    }
}

// Test cases
#if DEBUG
import XCTest
class RegexBlockerTests: XCTestCase {
    func testRegexBlock() {
        let patterns = [
            BlocklistEntry(pattern: "^800[0-9]{7}$", isRegex: true),
            BlocklistEntry(pattern: "+15551234567", isRegex: false)
        ]
        XCTAssertTrue(RegexBlocker.matches(number: "8001234567", patterns: patterns))
        XCTAssertTrue(RegexBlocker.matches(number: "+15551234567", patterns: patterns))
        XCTAssertFalse(RegexBlocker.matches(number: "9001234567", patterns: patterns))
    }
}
#endif
