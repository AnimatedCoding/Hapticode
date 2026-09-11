//
//  UIKitHaptics.swift
//  Hapticode
//
//  Created by Noah on 7/13/26.
//

import SwiftUI

#if os(macOS)
#else
struct UIKitNotificationHaptics: View {
    let impactHaptics = [
        UIKitNotificationHaptic(name: "Error", haptic: .error, docURL: URL(string: "https://developer.apple.com/documentation/uikit/uinotificationfeedbackgenerator/feedbacktype/error")!),
        UIKitNotificationHaptic(name: "Success", haptic: .success, docURL: URL(string: "https://developer.apple.com/documentation/uikit/uinotificationfeedbackgenerator/feedbacktype/success")!),
        UIKitNotificationHaptic(name: "Warning", haptic: .warning, docURL: URL(string: "https://developer.apple.com/documentation/uikit/uinotificationfeedbackgenerator/feedbacktype/warning")!),
    ]
    @State private var info = false
    var body: some View {
        Section {
            ForEach(impactHaptics) { haptic in
                UIKitNotificationHapticRow(haptic: haptic)
            }
        } header: {
            HStack {
                Text("UIKit Notification Feedback Generator")
                Spacer()
                Button(action: {
                    info = true
                }) {
                    Image(systemName: "info")
                }
                .sheet(isPresented: $info, content: {
                    UIKitNotificationHapticsInfo()
                })
            }
        }
    }
}

struct UIKitNotificationHapticsInfo: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStackOldCompatible {
            List {
                Text("These are haptics you can get with UINotificationFeedbackGenerator. Here's an example:")
                ScrollView(.horizontal) {
                    Text(
"""
struct ContentView: View {
    var body: some View {
        Button("Play .success") {
            let impactGenerator = UINotificationFeedbackGenerator()
            impactGenerator.prepare()
            impactGenerator.notificationOccurred(.success)
        }
    }
}
"""
                    )
                    .listRowBackground (
                        RoundedRectangle(cornerSize: CGSize(width: 0.5, height: 0.5), style: .continuous)
                            .foregroundStyle(.background)
                    )
                }
                SafariViewButton(title: "Docs", url: URL(string: "https://developer.apple.com/documentation/uikit/uinotificationfeedbackgenerator")!)
            }
            .listRowSeparator(.hidden)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}

struct UIKitNotificationHaptic: Haptic {
    var id = UUID()
    var name: String
    var haptic: UINotificationFeedbackGenerator.FeedbackType
    var docURL: URL
    var platforms: [Platform] = []
}

extension UINotificationFeedbackGenerator.FeedbackType: @retroactive Decodable {}
extension UINotificationFeedbackGenerator.FeedbackType: @retroactive Encodable {}

struct UIKitNotificationHapticRow: View {
    @State private var info = false
    let haptic: UIKitNotificationHaptic
    
    init(haptic: UIKitNotificationHaptic) {
        self.haptic = haptic
    }
    var body: some View {
        RowView(button: {
            let impactGenerator = UINotificationFeedbackGenerator()
            impactGenerator.prepare()
            impactGenerator.notificationOccurred(haptic.haptic)
        }, haptic: haptic)
    }
}

#Preview {
    List {
        UIKitNotificationHaptics()
    }
}
#endif
