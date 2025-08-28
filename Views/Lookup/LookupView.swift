import SwiftUI

struct LookupView: View {
    @ObservedObject var viewModel: LookupViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter number", text: $viewModel.searchNumber)
                        .keyboardType(.phonePad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("Lookup") {
                        viewModel.lookup()
                    }
                }.padding()
                if let info = viewModel.result {
                    VStack(alignment: .leading) {
                        Text("Number: \(info.number)")
                        if let name = info.name {
                            Text("Name: \(name)")
                        }
                        if let type = info.type {
                            Text("Type: \(type)")
                        }
                    }.padding()
                } else {
                    Text("No info found.").foregroundColor(.gray)
                }
                Spacer()
            }
            .navigationTitle("Lookup")
        }
    }
}
