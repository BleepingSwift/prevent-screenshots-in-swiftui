import SwiftUI

struct BalanceView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Account Summary").font(.title)

            SecureContent {
                Text("$10,234.56").font(.largeTitle.bold())
            }
            .frame(height: 50)
        }
        .padding()
    }
}