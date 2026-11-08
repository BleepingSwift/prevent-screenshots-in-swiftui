import SwiftUI
import UIKit

struct SecureContent<Content: View>: UIViewRepresentable {
    @ViewBuilder var content: Content

    func makeCoordinator() -> Coordinator { Coordinator() }

    func makeUIView(context: Context) -> UITextField {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.isUserInteractionEnabled = false

        // iOS applies secure rendering to this internal view. It's undocumented,
        // so if it ever goes away, show nothing rather than exposing the content.
        guard let canvas = field.subviews.first else { return field }

        let host = UIHostingController(rootView: content)
        host.view.backgroundColor = .clear
        host.view.translatesAutoresizingMaskIntoConstraints = false
        canvas.addSubview(host.view)

        NSLayoutConstraint.activate([
            host.view.leadingAnchor.constraint(equalTo: field.leadingAnchor),
            host.view.trailingAnchor.constraint(equalTo: field.trailingAnchor),
            host.view.topAnchor.constraint(equalTo: field.topAnchor),
            host.view.bottomAnchor.constraint(equalTo: field.bottomAnchor),
        ])

        context.coordinator.host = host
        return field
    }

    func updateUIView(_ field: UITextField, context: Context) {
        context.coordinator.host?.rootView = content
    }

    final class Coordinator {
        var host: UIHostingController<Content>?
    }
}