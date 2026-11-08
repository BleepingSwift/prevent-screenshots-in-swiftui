import SwiftUI

final class ScreenshotLog: ObservableObject {
    @Published var count = 0
    @Published var lastTaken: Date?

    func record() {
        count += 1
        lastTaken = Date()
    }
}

struct ContentView: View {
    @StateObject private var log = ScreenshotLog()
    @State private var protectBalance = true

    var body: some View {
        NavigationStack {
            List {
                Section("Detection") {
                    AccountView()
                    LabeledContent("Screenshots taken", value: "\(log.count)")
                    if let last = log.lastTaken {
                        LabeledContent("Last one") {
                            Text(last, style: .time)
                        }
                    }
                }

                Section {
                    Toggle("Hide balance from screenshots", isOn: $protectBalance)

                    if protectBalance {
                        BalanceView()
                    } else {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Account Summary").font(.title)
                            Text("$10,234.56").font(.largeTitle.bold())
                                .frame(height: 50)
                        }
                        .padding()
                    }
                } header: {
                    Text("Blocking")
                } footer: {
                    Text("Take a screenshot with the toggle on and off. The protected balance comes out blank in the captured image and in screen recordings.")
                }
            }
            .navigationTitle("Screenshot Guard")
            .onScreenshot { log.record() }
        }
    }
}

#Preview {
    ContentView()
}