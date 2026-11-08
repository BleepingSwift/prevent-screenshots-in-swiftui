import SwiftUI

struct AccountView: View {
    @State private var showWarning = false

    var body: some View {
        Text("Account Number: 1234-5678-9012")
            .onScreenshot { showWarning = true }
            .alert("Screenshot Detected", isPresented: $showWarning) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Please keep this information private.")
            }
    }
}