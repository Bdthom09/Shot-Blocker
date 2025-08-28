import XCTest
@testable import Shot_Blocker

final class RegexBlockerTests: XCTestCase {
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
