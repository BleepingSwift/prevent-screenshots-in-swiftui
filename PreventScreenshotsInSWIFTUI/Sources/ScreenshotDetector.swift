import SwiftUI
import UIKit

struct ScreenshotDetector: ViewModifier {
    let onScreenshot: () -> Void

    func body(content: Content) -> some View {
        content.onReceive(NotificationCenter.default.publisher(
            for: UIApplication.userDidTakeScreenshotNotification
        )) { _ in
            onScreenshot()
        }
    }
}

extension View {
    func onScreenshot(perform action: @escaping () -> Void) -> some View {
        modifier(ScreenshotDetector(onScreenshot: action))
    }
}