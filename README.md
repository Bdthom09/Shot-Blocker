# Shot Blocker

Shot Blocker is an iOS app designed to help users block unwanted phone calls using custom blocklists and regex-based filtering. The app provides a user-friendly interface for managing blocklists, reporting spam calls, and looking up phone numbers.

## Features

- **Blocklist Management**: Add, edit, and remove phone numbers or patterns to block unwanted calls.
- **Regex Filtering**: Use regular expressions to create advanced blocking rules.
- **Lookup Service**: Search and view details about incoming phone numbers.
- **Spam Reporting**: Report spam calls to help improve community protection.
- **Call Directory Extension**: Integrates with iOS CallKit to block calls at the system level.

## Project Structure

- `Shot Blocker/` — Main app source files (SwiftUI views, app entry, assets)
- `Models/` — Data models for phone numbers and blocklists
- `ViewModels/` — Logic for blocklist, lookup, and reports
- `Views/` — UI components for blocklist, lookup, and reports
- `Services/` — Mock services for lookup and reporting
- `Utilities/` — Helper classes (e.g., regex blocker, blocklist store)
- `CallDirectoryExtension/` — CallKit extension handler
- `Shot BlockerTests/` — Unit tests
- `Shot BlockerUITests/` — UI tests

## Getting Started

1. **Clone the repository**
   ```bash
   git clone https://github.com/Bdthom09/Shot-Blocker.git
   ```
2. **Open in Xcode**
   - Open `Shot Blocker.xcodeproj` in Xcode.
3. **Build and Run**
   - Select the `Shot Blocker` scheme and run on a simulator or device.

## Requirements

- Xcode 14+
- iOS 15.0+

## Contributing

Contributions are welcome! Please open issues or submit pull requests for improvements or bug fixes.

## License

This project is licensed under the MIT License.
