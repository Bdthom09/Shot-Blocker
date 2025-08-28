import SwiftUI

struct ReportsView: View {
    @ObservedObject var viewModel: ReportsViewModel
    @State private var number: String = ""
    @State private var reason: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.reports) { report in
                        VStack(alignment: .leading) {
                            Text(report.number)
                            if let reason = report.reason {
                                Text(reason).font(.caption)
                            }
                            Text("\(report.date, formatter: dateFormatter)").font(.caption2).foregroundColor(.gray)
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.map { viewModel.reports[$0] }.forEach(viewModel.removeReport)
                    }
                }
                HStack {
                    TextField("Number", text: $number)
                        .keyboardType(.phonePad)
                    TextField("Reason", text: $reason)
                    Button("Report") {
                        guard !number.isEmpty else { return }
                        viewModel.report(number: number, reason: reason.isEmpty ? nil : reason)
                        number = ""
                        reason = ""
                    }
                    .disabled(number.isEmpty)
                }.padding()
            }
            .navigationTitle("Reports")
        }
    }
}

private let dateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.dateStyle = .short
    df.timeStyle = .short
    return df
}()
