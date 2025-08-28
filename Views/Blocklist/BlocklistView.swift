import SwiftUI

struct BlocklistView: View {
    @ObservedObject var viewModel: BlocklistViewModel
    @State private var newPattern: String = ""
    @State private var isRegex: Bool = false
    @State private var description: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.entries) { entry in
                        HStack {
                            Text(entry.pattern)
                            if entry.isRegex {
                                Text("(Regex)").font(.caption).foregroundColor(.gray)
                            }
                            Spacer()
                            if let desc = entry.description {
                                Text(desc).font(.caption)
                            }
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.map { viewModel.entries[$0] }.forEach(viewModel.removeEntry)
                    }
                }
                HStack {
                    TextField("Pattern or number", text: $newPattern)
                    Toggle("Regex", isOn: $isRegex)
                        .labelsHidden()
                    TextField("Description", text: $description)
                    Button("Add") {
                        guard !newPattern.isEmpty else { return }
                        let entry = BlocklistEntry(pattern: newPattern, isRegex: isRegex, description: description.isEmpty ? nil : description)
                        viewModel.addEntry(entry)
                        newPattern = ""
                        description = ""
                        isRegex = false
                    }
                    .disabled(newPattern.isEmpty)
                }.padding()
            }
            .navigationTitle("Blocklist")
        }
    }
}
