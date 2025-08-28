import Foundation
import CallKit

class CallDirectoryHandler: CXCallDirectoryProvider {
    override func beginRequest(with context: CXCallDirectoryExtensionContext) {
        context.delegate = self
        addAllBlockingPhoneNumbers(to: context)
        addAllIdentificationPhoneNumbers(to: context)
        context.completeRequest()
    }
    
    private func addAllBlockingPhoneNumbers(to context: CXCallDirectoryExtensionContext) {
        let entries = BlocklistStore.loadBlocklist()
        for entry in entries {
            if !entry.isRegex, let number = Int64(entry.pattern.filter("0123456789".contains)) {
                context.addBlockingEntry(withNextSequentialPhoneNumber: number)
            }
            // Regex-based blocking is not natively supported by CallKit, but we can block known numbers
        }
    }
    
    private func addAllIdentificationPhoneNumbers(to context: CXCallDirectoryExtensionContext) {
        // Optionally add identification entries (e.g., for known spam)
    }
}

extension CallDirectoryHandler: CXCallDirectoryExtensionContextDelegate {
    func requestFailed(for extensionContext: CXCallDirectoryExtensionContext, withError error: Error) {
        // Handle errors
    }
}
